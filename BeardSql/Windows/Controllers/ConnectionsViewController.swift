//
//  ConnectionsViewController.swift
//  BeardSql
//
//  Created by Swen van Zanten on 23-11-16.
//  Copyright © 2016 Swen van Zanten. All rights reserved.
//

import Cocoa

class ConnectionsViewController: NSViewController
{

    @IBOutlet weak var hostInput: NSTextField!
    @IBOutlet weak var userInput: NSTextField!
    @IBOutlet weak var passwordInput: NSTextField!
    @IBOutlet weak var databaseInput: NSTextField!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do view setup here.
        
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
        
        NotificationCenter.default.post(name: .DatabaseConnectionConnected, object: nil)
        
        self.dismissViewController(self)
    }
    
}
