//
//  ExampleServiceProvider.swift
//  BeardSql
//
//  Created by Swen van Zanten on 12-11-16.
//  Copyright © 2016 Swen van Zanten. All rights reserved.
//

import Foundation
import BeardFramework

class ExampleServiceProvider: BServiceProvider, BServiceProvidable
{
    func boot()
    {
        //
    }
    
    func register()
    {
        self.container.singleton(name: "user", handler: { container in
            return User(name: container.get(name: "mistro") as! String)
        })
        
        self.container.singleton(name: "mistro", handler: { container in
            return "gerda"
        })
    }
}
