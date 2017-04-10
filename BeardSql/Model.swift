//
//  Model.swift
//  BeardSql
//
//  Created by Swen van Zanten on 06-11-16.
//  Copyright © 2016 Swen van Zanten. All rights reserved.
//

import Foundation
import MySQL

class Model
{
    var columns: [(name: String, value: Node)]? = nil

    func get(name: String) -> (name: String, value: Node)?
    {
        for column in self.columns ?? [] {
            if (column.name == name) {
                return column
            }
        }

        return nil
    }
}
