//
//  Table.swift
//  BeardSql
//
//  Created by Swen van Zanten on 15-11-16.
//  Copyright © 2016 Swen van Zanten. All rights reserved.
//

import Foundation
import MySQL

class Table
{
    ///
    /// The type of table.
    ///
    private var type: String = ""
    
    ///
    /// The name of the table.
    ///
    private var name: String = ""
    
    ///
    /// Create a new table.
    ///
    init(type: String, name: String)
    {
        self.type = type
        self.name = name
    }
    
    ///
    /// Contruct the table
    ///
    convenience init(nodeResult: [String: Node], database: String)
    {
        let type = nodeResult["Table_type"]?.string ?? ""
        let name = nodeResult["Tables_in_\(database.lowercased())"]?.string ?? ""
        
        self.init(type: type, name: name)
    }
    
    func getType() -> String
    {
        return self.type
    }
    
    func getName() -> String
    {
        return self.name
    }
}
