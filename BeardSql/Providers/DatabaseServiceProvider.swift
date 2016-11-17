//
//  DatabaseServiceProvider.swift
//  BeardSql
//
//  Created by Swen van Zanten on 15-11-16.
//  Copyright © 2016 Swen van Zanten. All rights reserved.
//

import Foundation
import BeardFramework

class DatabaseServiceProvider: BServiceProvider, BServiceProvidable
{
    func boot()
    {
        //
    }
    
    func register()
    {
        self.container.singleton(name: "connector", handler: { container in
            return Connector(console: container.get(name: "console") as! Console)
        })
        
        self.container.singleton(name: "repository", handler: { container in
            return Repository(connector: container.get(name: "connector") as! Connector)
        })
    }
}
