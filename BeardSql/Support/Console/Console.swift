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
    
    func add(query: String) -> Void
    {
        let statement = Statement(query: query, user: "Swen")
        
        self.statements.append(statement)
    }
}
