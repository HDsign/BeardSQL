//
//  MySQLSyntax.swift
//  BeardSqlEditor
//
//  Created by Swen van Zanten on 22-11-16.
//  Copyright © 2016 Swen van Zanten. All rights reserved.
//

import Foundation

class MySQLSyntax: SyntaxProtocol
{
    let keywords: [String] = [
        "SELECT",
        "FROM",
        "WHERE",
        "INTO",
        "AS",
        "DELETE",
        "INSERT",
        "UPDATE",
        "GROUP",
        "ORDER",
        "HAVING",
        "AND",
        "BY",
        "OR",
        "JOIN",
        "LEFT",
        "RIGHT",
        "INNER",
        "ON",
        "IF",
        "IFNULL",
        "CONCAT",
        "GROUP_CONCAT",
        "SUM",
        "COUNT",
        "LIMIT",
        "OFFSET"
    ]
    
    let connectors: [String] = [
        ".",
        ";",
        ",",
        "`",
        "=",
    ]
    
    let calculations: [String] = [
        "+",
        "*",
        "-",
        "/",
        "%",
        "(",
        ")",
    ]
    
    func isKeyword(search: String) -> Bool
    {
        return self.keywords.contains(search.uppercased())
    }
    
    func isConnector(search: String) -> Bool
    {
        return self.connectors.contains(search)
    }
    
    func isCalculator(search: String) -> Bool
    {
        return self.calculations.contains(search)
    }
}
