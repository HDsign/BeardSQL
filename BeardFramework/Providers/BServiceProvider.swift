//
//  BServiceProvider.swift
//  BeardSql
//
//  Created by Swen van Zanten on 11-11-16.
//  Copyright © 2016 Swen van Zanten. All rights reserved.
//

import Foundation

open class BServiceProvider
{
    public var container: BContainer
    
    required public init(container: BContainer)
    {
        self.container = container
    }
}
