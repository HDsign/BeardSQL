//
//  Console.swift
//  BeardSql
//
//  Created by Swen van Zanten on 16-11-16.
//  Copyright © 2016 Swen van Zanten. All rights reserved.
//

import Foundation

class Console
{
    private var statements: [Statement] = []

    private var statementAddedListeners: [(_ statement: Statement) -> Void] = []

    func add(connection: String, database: String, query: String) -> Void
    {
        let statement = Statement(connection: connection, database: database, query: query)

        self.statements.append(statement)

        for listener in self.statementAddedListeners {
            listener(statement)
        }
    }

    func addedStatement(handler: @escaping (_ statement: Statement) -> Void)
    {
        self.statementAddedListeners.append(handler)
    }

    func getStatement(byRow: Int) -> Statement?
    {
        if (self.statements.indices.contains(byRow)) {
            return self.statements[byRow]
        }

        return nil
    }

    func numberOfStatements() -> Int
    {
        return self.statements.count
    }
}
