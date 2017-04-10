//
//  ConnectionsViewController.swift
//  BeardSql
//
//  Created by Swen van Zanten on 23-11-16.
//  Copyright © 2016 Swen van Zanten. All rights reserved.
//

import Cocoa
import MySQL

class ConnectionsViewController: NSViewController
{
    @IBOutlet weak var outlineView: NSOutlineView!
    @IBOutlet weak var hostInput: NSTextField!
    @IBOutlet weak var userInput: NSTextField!
    @IBOutlet weak var passwordInput: NSSecureTextField!
    @IBOutlet weak var databaseInput: NSTextField!

    let favorites: [Favorite] = [
        Favorite(name: "Edibulb", host: "127.0.0.1", user: "root", password: "root", database: "edibulb"),
        Favorite(name: "Laravel", host: "127.0.0.1", user: "root", password: "root", database: "laravel"),
        Favorite(name: "MAMP", host: "127.0.0.1", user: "root", password: "root")
    ]

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.setInputs()

        self.outlineView.reloadData()
    }

    func setInputs()
    {
        self.hostInput.stringValue = connector().host
        self.userInput.stringValue = connector().user
        self.passwordInput.stringValue = connector().password
        self.databaseInput.stringValue = connector().database
    }
    
    @IBAction func connectButtonClicked(_ sender: Any)
    {
        connector().host = self.hostInput.stringValue
        connector().user = self.userInput.stringValue
        connector().password = self.passwordInput.stringValue
        connector().database = self.databaseInput.stringValue

        if (self.canConnect()) {
            NotificationCenter.default.post(name: .DatabaseConnectionConnected, object: nil)

            self.dismissViewController(self)
        }
    }

    func canConnect() -> Bool
    {
        do {
            try connector().connect()

            return true
        } catch MySQL.Error.connection(let error) {
            self.showConnectionError(error: error)
        } catch {
            self.showConnectionError(error: String(describing: error))
        }

        return false
    }

    func showConnectionError(error: String) -> Void
    {
        let alert = NSAlert()
        alert.alertStyle = .warning
        alert.messageText = error
        alert.runModal()
    }
}

extension ConnectionsViewController: NSOutlineViewDelegate, NSOutlineViewDataSource
{
    func outlineView(_ outlineView: NSOutlineView, numberOfChildrenOfItem item: Any?) -> Int
    {
        return self.favorites.count
    }

    func outlineView(_ outlineView: NSOutlineView, child index: Int, ofItem item: Any?) -> Any
    {
        return self.favorites[index]
    }

    func outlineView(_ outlineView: NSOutlineView, isItemExpandable item: Any) -> Bool
    {
        return false
    }

    func outlineView(_ outlineView: NSOutlineView, viewFor tableColumn: NSTableColumn?, item: Any) -> NSView?
    {
        let connection = item as! Favorite

        let cell = outlineView.make(withIdentifier: "DataCell", owner: self) as! NSTableCellView

        cell.textField?.stringValue = connection.name

        return cell
    }

    func outlineViewSelectionDidChange(_ notification: Notification)
    {
        guard let outlineView = notification.object as? NSOutlineView else {
            return
        }

        let favorite = outlineView.item(atRow: outlineView.selectedRow) as! Favorite

        self.hostInput.stringValue = favorite.host
        self.userInput.stringValue = favorite.user
        self.passwordInput.stringValue = favorite.password
        self.databaseInput.stringValue = favorite.database
    }
}
