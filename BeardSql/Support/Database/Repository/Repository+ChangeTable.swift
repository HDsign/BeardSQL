//
//  Repository+ChangeTable.swift
//  BeardSql
//
//  Created by Swen van Zanten on 16-11-16.
//  Copyright © 2016 Swen van Zanten. All rights reserved.
//

import Foundation

extension Repository
{
    func changeTable(table: String)
    {
        self.currentTable = table
        
        for listener in self.changeTableListeners {
            listener(table)
        }
    }
    
    func changedTable(handler: @escaping (_ table: String) -> Void)
    {
        self.changeTableListeners.append(handler)
    }
}
