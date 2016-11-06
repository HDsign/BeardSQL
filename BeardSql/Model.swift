//
//  Model.swift
//  BeardSql
//
//  Created by Swen van Zanten on 06-11-16.
//  Copyright © 2016 Swen van Zanten. All rights reserved.
//

import Foundation

class Model
{
    var columns: [String: Any]? = nil
    
    init(id: Int, name: String)
    {
        self.columns = [
            "id": id,
            "name": name,
            "hello": "Ik ben gerrie"
        ]
    }
}
