//
//  InstanceHandler.swift
//  BeardSql
//
//  Created by Swen van Zanten on 12-11-16.
//  Copyright © 2016 Swen van Zanten. All rights reserved.
//

import Foundation

class InstanceHandler
{
    var container: BContainer?
    var instance: Any? = nil

    var name: String = ""
    var handler: (BContainer) -> Any = { _ in
        return 0
    }

    init(name: String, handler: @escaping (BContainer) -> Any, container: BContainer)
    {
        self.name = name
        self.handler = handler
        self.container = container
    }

    func createInstance() -> Any?
    {
        if let container = self.container {
            return self.handler(container)
        }

        return nil
    }
}
