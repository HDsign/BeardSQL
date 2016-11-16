//
//  Connector.swift
//  BeardSql
//
//  Created by Swen van Zanten on 15-11-16.
//  Copyright © 2016 Swen van Zanten. All rights reserved.
//

import Foundation
import MySQL

class Connector
{
    var host: String = "127.0.0.1"
    var user: String = "root"
    var password: String = "root"
    var database: String = "example"
    
    func mysql() -> Database?
    {
        do {
            return try MySQL.Database(
                host: self.host,
                user: self.user,
                password: self.password,
                database: self.database
            )
        } catch {
            print(error)
            
            return nil
        }
    }
    
    func execute(_ query: String) -> [[String: Node]]
    {
        do {
            return try self.mysql()?.execute(query) ?? [[:]]
        } catch {
            print(error)
            
            return [[:]]
        }
    }
}
