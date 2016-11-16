//
//  Repository.swift
//  BeardSql
//
//  Created by Swen van Zanten on 15-11-16.
//  Copyright © 2016 Swen van Zanten. All rights reserved.
//

import Foundation
import MySQL

class Repository
{
    ///
    /// The database connection.
    ///
    var connector: Connector? = nil
    
    var currentTable: String = ""
    
    var listeners: [(_ table: String) -> Void] = []
    
    ///
    /// Create a new repository.
    ///
    init(connector: Connector)
    {
        self.connector = connector
    }
    
    ///
    /// Get all the tables of the database.
    ///
    func getTables() -> [Table]
    {
        do {
            let tables = try self
                .connector?
                .mysql()?
                .execute("SHOW /*!50002 FULL*/ TABLES;")
                ?? [[:]]
            
            return tables.map { (table: [String: Node]) in
                return Table(nodeResult: table, database: (self.connector?.database) ?? "")
            }
        } catch {
            print(error)
            
            return []
        }
    }
    
    func changeTable(table: String)
    {
        self.currentTable = table
        
        for listener in self.listeners {
            listener(table)
        }
    }
    
    func changedTable(handler: @escaping (_ table: String) -> Void)
    {
        self.listeners.append(handler)
    }
}
