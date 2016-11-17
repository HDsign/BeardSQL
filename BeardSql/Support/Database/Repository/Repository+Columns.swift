//
//  Repository+Columns.swift
//  BeardSql
//
//  Created by Swen van Zanten on 16-11-16.
//  Copyright © 2016 Swen van Zanten. All rights reserved.
//

import Foundation
import MySQL

extension Repository
{
    ///
    /// Get all the columns of the selected table.
    ///
    func getColumns(table: String) -> [Column]
    {
        do {
            let columns = try self
                .connector?
                .mysql()?
                .execute("SHOW COLUMNS FROM \(table);")
                ?? [[:]]
            
            return columns.map { (rawColumn: [String: Node]) in
                let column = Column()
                column.field = rawColumn["Field"]?.string ?? ""
                column.type  = rawColumn["Type"]?.string ?? ""
                column.null  = (rawColumn["Null"]?.string)! == "YES" ? true : false
                column.key   = rawColumn["Key"]?.string ?? ""
                column.`default` = rawColumn["Default"]?.string ?? ""
                column.extra = rawColumn["Extra"]?.string ?? ""
                
                return column
            }
        } catch {
            print(error)
            
            return []
        }
    }
}
