//
//  Singleton.swift
//  BeardSql
//
//  Created by Swen van Zanten on 11-11-16.
//  Copyright © 2016 Swen van Zanten. All rights reserved.
//

import Foundation

class Singleton: InstanceHandler, BSingletonable
{
    func getInstance() -> Any?
    {
        if (self.instance == nil) {
            self.instance = self.createInstance()
        }
        
        return self.instance
    }
}
