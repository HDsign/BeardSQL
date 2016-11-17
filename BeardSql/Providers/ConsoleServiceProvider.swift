//
//  ConsoleServiceProvider.swift
//  BeardSql
//
//  Created by Swen van Zanten on 16-11-16.
//  Copyright © 2016 Swen van Zanten. All rights reserved.
//

import Foundation
import BeardFramework

class ConsoleServiceProvider: BServiceProvider, BServiceProvidable
{
    func boot()
    {
        //
    }
    
    func register() {
        self.container.singleton(name: "console", handler: { container in
            return Console()
        })
    }
}
