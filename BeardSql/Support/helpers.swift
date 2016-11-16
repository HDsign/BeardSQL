//
//  helpers.swift
//  BeardSql
//
//  Created by Swen van Zanten on 16-11-16.
//  Copyright © 2016 Swen van Zanten. All rights reserved.
//

import Cocoa
import BeardFramework

///
/// Get the beard container
///
func container() -> BeardContainer
{
    return (NSApplication.shared().delegate as! AppDelegate).container()
}

///
/// Get the connector instance from the container.
///
func connector() -> Connector
{
    return container().get(name: "connector") as! Connector
}

///
/// Get the repository instance from the container.
///
func repo() -> Repository
{
    return container().get(name: "repository") as! Repository
}
