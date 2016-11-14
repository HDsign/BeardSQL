//
//  BServiceProvidable.swift
//  BeardSql
//
//  Created by Swen van Zanten on 11-11-16.
//  Copyright © 2016 Swen van Zanten. All rights reserved.
//

import Foundation

public protocol BServiceProvidable
{
    init(container: BContainer)
    
    func boot() -> Void
    func register() -> Void
}
