//
//  BContainer.swift
//  BeardSql
//
//  Created by Swen van Zanten on 11-11-16.
//  Copyright © 2016 Swen van Zanten. All rights reserved.
//

import Foundation

public protocol BContainer
{
    func bind(name: String, handler: @escaping (_ container: BContainer) -> Any) -> Void
    func singleton(name: String, handler: @escaping (_ container: BContainer) -> Any) -> Void
    func get(name: String) -> Any?
}
