//
// Created by Swen van Zanten on 01-04-17.
// Copyright (c) 2017 Swen van Zanten. All rights reserved.
//

import Foundation

class Favorite
{
    var name: String = ""
    var host: String = ""
    var user: String = ""
    var password: String = ""
    var database: String = ""

    init(name: String, host: String, user: String, password: String, database: String = "")
    {
        self.name = name
        self.host = host
        self.user = user
        self.password = password
        self.database = database
    }
}
