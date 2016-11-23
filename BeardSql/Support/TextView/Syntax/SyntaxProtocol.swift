//
//  SyntaxProtocol.swift
//  BeardSql
//
//  Created by Swen van Zanten on 23-11-16.
//  Copyright © 2016 Swen van Zanten. All rights reserved.
//

import Foundation

protocol SyntaxProtocol
{
    func isKeyword(search: String) -> Bool
    
    func isConnector(search: String) -> Bool
    
    func isCalculator(search: String) -> Bool
}
