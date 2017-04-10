//
//  Connector.swift
//  BeardSql
//
//  Created by Swen van Zanten on 15-11-16.
//  Copyright © 2016 Swen van Zanten. All rights reserved.
//

import Cocoa
import MySQL

class Connector
{
    var mysqlInstance: Database?
    var console:       Console?

    var host:     String = ""
    var user:     String = ""
    var password: String = ""
    var database: String = ""

    var connection: Connection? = nil
    var connected:  Bool        = false

    init(console: Console)
    {
        self.console = console
    }

    func mysql() -> Database?
    {
        return self.mysqlInstance
    }

    func execute(_ query: String) -> [[String: Node]]
    {
        self.console?.add(connection: self.host, database: self.database, query: query)

        do {
            return try self.mysql()?.execute(query, [], self.connection) ?? [[:]]
        } catch MySQL.Error.prepare(let error) {
            let alert = NSAlert()
            alert.alertStyle = .warning
            alert.messageText = error
            alert.runModal()
            print(error)

            return [[:]]
        } catch {
            print(error)

            return [[:]]
        }
    }

    func executeOrdered(_ query: String) -> [[(name: String, value: Node)]]
    {
        self.console?.add(connection: self.host, database: self.database, query: query)

        do {
            return try self.mysql()?.executeOrdered(query, [], self.connection) ?? []
        } catch MySQL.Error.prepare(let error) {
            let alert = NSAlert()
            alert.alertStyle = .warning
            alert.messageText = error.string!
            alert.runModal()
            print(error)

            return []
        } catch {
            print(error)

            return []
        }
    }

    func connect() throws
    {
        self.mysqlInstance = try MySQL.Database(
            host: self.host,
            user: self.user,
            password: self.password,
            database: self.database
        )

        self.connection = try self.mysqlInstance?.makeConnection()

        self.connected = true
    }

    func hasConnection() -> Bool
    {
        return self.connected
    }
}

extension NSNotification.Name
{
    public static let DatabaseConnectionLost         = NSNotification.Name("DatabaseConnectionLost")
    public static let DatabaseConnectionConnected    = NSNotification.Name("DatabaseConnectionConnected")
    public static let DatabaseConnectionDisconnected = NSNotification.Name("DatabaseConnectionLost")
}
