//
//  Statement.swift
//  BeardSql
//
//  Created by Swen van Zanten on 16-11-16.
//  Copyright © 2016 Swen van Zanten. All rights reserved.
//

import Foundation

class Statement
{
    var time: NSDate? = nil
    var connection: String = ""
    var database: String = ""
    var query: String = ""
    
    init(connection: String, database: String, query: String)
    {
        self.connection = connection
        self.database = database
        self.query = query
        self.time = NSDate()
    }
    
    func get(property: String, trim: String = "") -> String
    {
        switch property.replacingOccurrences(of: trim, with: "") {
        case "time":
            return "10-10-2016"
        case "connection":
            return self.connection
        case "database":
            return self.database
        case "query":
            return self.query
        default:
            return ""
        }
    }
}
