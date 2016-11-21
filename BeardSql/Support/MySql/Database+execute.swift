//
//  Database+execute.swift
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

extension Database
{
    /**
     Executes the MySQL query string with parameterized values.
     
     - parameter query: MySQL flavored SQL query string.
     - parameter values: Array of MySQL values to be parameterized.
     The number of Values MUST equal the number of `?` in the query string.
     
     - throws: Various `Database.Error` types.
     
     - returns: An array of `[String: Value]` results.
     May be empty if the call does not produce data.
     */
    @discardableResult
    public func executeOrdered(_ query: String, _ values: [NodeRepresentable] = [], _ on: Connection? = nil) throws -> [[(name: String, value: Node)]] {
        // If not connection is supplied, make a new one.
        // This makes thread-safety default.
        let connection: Connection
        if let c = on {
            connection = c
        } else {
            connection = try makeConnection()
        }
        
        return try connection.executeOrdered(query, values)
    }
}
