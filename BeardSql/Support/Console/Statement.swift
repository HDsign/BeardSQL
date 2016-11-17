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
    var user: String = ""
    var timestamp: NSDate? = nil
    var query: String = ""
    
    init(query: String, user: String)
    {
        self.query = query
        self.user = user
        self.timestamp = NSDate()
    }
}
