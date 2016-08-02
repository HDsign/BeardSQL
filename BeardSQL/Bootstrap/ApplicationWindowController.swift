//
//  ApplicationWindowController.swift
//  BeardSQL
//
//  Created by Swen van Zanten on 03-08-16.
//  Copyright © 2016 Swen van Zanten. All rights reserved.
//

import Cocoa

class ApplicationWindowController: NSWindowController
{

    override func windowDidLoad()
    {
        super.windowDidLoad()
    
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
        self.window?.titleVisibility = .Hidden
    }

    @IBAction func runQuery(sender: NSToolbarItem)
    {
        NSNotificationCenter.defaultCenter().postNotificationName("runQueryPushed", object: nil)
    }
}
