//
//  Connection+execute.swift
//  BeardSql
//
//  Created by Swen van Zanten on 21-11-16.
//  Copyright © 2016 Swen van Zanten. All rights reserved.
//

#if os(Linux)
#if MARIADB
    import CMariaDBLinux
    #else
    import CMySQLLinux
#endif
#else
    import CMySQLMac
#endif

import Core
import MySQL

extension Connection
{
    private var lock: Lock {
        get {
            return Lock()
        }
        set {
            self.lock = newValue
        }
    }

    @discardableResult
    public func executeOrdered(_ query: String, _ values: [NodeRepresentable] = []) throws -> [[(name: String, value: Node)]]
    {
        var returnable: [[(name: String, value: Node)]] = []
        try lock.locked {
            // Create a pointer to the statement
            // This should only fail if memory is limited.
            guard let statement = mysql_stmt_init(cConnection) else {
                throw Error.statement(error)
            }
            defer {
                mysql_stmt_close(statement)
            }

            // Prepares the created statement
            // This parses `?` in the query and
            // prepares them to attach parameterized bindings.
            guard mysql_stmt_prepare(statement, query, UInt(strlen(query))) == 0 else {
                throw Error.prepare(error)
            }

            // Transforms the `[Value]` array into bindings
            // and applies those bindings to the statement.
            let inputBinds = try Binds(values)
            guard mysql_stmt_bind_param(statement, inputBinds.cBinds) == 0 else {
                throw Error.inputBind(error)
            }

            // Fetches metadata from the statement which has
            // not yet run.
            if let metadata = mysql_stmt_result_metadata(statement) {
                defer {
                    mysql_free_result(metadata)
                }

                // Parse the fields (columns) that will be returned
                // by this statement.
                let fields: Fields
                do {
                    fields = try Fields(metadata)
                } catch {
                    throw Error.fetchFields(self.error)
                }

                // Use the fields data to create output bindings.
                // These act as buffers for the data that will
                // be returned when the statement is executed.
                let outputBinds = Binds(fields)

                // Bind the output bindings to the statement.
                guard mysql_stmt_bind_result(statement, outputBinds.cBinds) == 0 else {
                    throw Error.outputBind(error)
                }

                // Execute the statement!
                // The data is ready to be fetched when this completes.
                guard mysql_stmt_execute(statement) == 0 else {
                    throw Error.execute(error)
                }

                var results: [[(name: String, value: Node)]] = []

                // Iterate over all of the rows that are returned.
                // `mysql_stmt_fetch` will continue to return `0`
                // as long as there are rows to be fetched.
                while mysql_stmt_fetch(statement) == 0 {
                    var parsed: [(name: String, value: Node)] = []

                    // For each row, loop over all of the fields expected.
                    for (i, field) in fields.fields.enumerated() {

                        // For each field, grab the data from
                        // the output binding buffer and add
                        // it to the parsed results.
                        let output = outputBinds[i]
                        parsed.append((name: field.name, value: output.value))
                    }
                    results.append(parsed)

                    // reset the bindings onto the statement to
                    // signal that they may be reused as buffers
                    // for the next row fetch.
                    guard mysql_stmt_bind_result(statement, outputBinds.cBinds) == 0 else {
                        throw Error.outputBind(error)
                    }
                }

                returnable = results
            } else {
                // no data is expected to return from
                // this query, simply execute it.
                guard mysql_stmt_execute(statement) == 0 else {
                    throw Error.execute(error)
                }
                returnable = []
            }
        }

        return returnable
    }
}
