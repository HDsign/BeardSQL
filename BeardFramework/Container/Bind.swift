//
//  Bind.swift
//  BeardSql
//
//  Created by Swen van Zanten on 11-11-16.
//  Copyright © 2016 Swen van Zanten. All rights reserved.
//

import Foundation

class Bind: InstanceHandler, BBindable
{
    func getInstance() -> Any?
    {
        return self.createInstance()
    }
}
