//
//  Repository+DropTable.swift
//  BeardSql
//
//  Created by Swen van Zanten on 16-11-16.
//  Copyright © 2016 Swen van Zanten. All rights reserved.
//

import Foundation

extension Repository
{
    func dropTable(table: String) -> Void
    {
        do {
            let _ = try self.connector?.mysql()?.execute("DROP TABLE \(table)")
        } catch {
            print(error)
        }

        for listener in self.dropTableListeners {
            listener(table)
        }
    }

    func droppedTable(handler: @escaping (_ table: String) -> Void)
    {
        self.dropTableListeners.append(handler)
    }
}
