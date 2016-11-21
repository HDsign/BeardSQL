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
    
    var changeTableListeners: [(_ table: String) -> Void] = []
    
    var dropTableListeners: [(_ table: String) -> Void] = []
    
    ///
    /// Create a new repository.
    ///
    init(connector: Connector)
    {
        self.connector = connector
    }
}
