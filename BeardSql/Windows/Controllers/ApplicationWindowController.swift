//
//  ApplicationWindowController.swift
//  BeardSql
//
//  Created by Swen van Zanten on 05-11-16.
//  Copyright © 2016 Swen van Zanten. All rights reserved.
//

import Cocoa

class ApplicationWindowController: NSWindowController
{

    override func windowDidLoad()
    {
        super.windowDidLoad()
        
        self.bootstrapping();
    }
    
    func bootstrapping()
    {
        self.window?.titleVisibility = .hidden
        self.window?.toolbar?.displayMode = .iconAndLabel
        
        self.window?.contentView?.wantsLayer = true
        self.window?.contentView?.layer?.masksToBounds = true
        
        self.window?.miniwindowTitle = "BeardSql"
    }
    
    @IBAction func toolbarAction(_ sender: NSToolbarItem) {
        if let tag = (sender as AnyObject).tag {
            self.switchSplitViewControllerByTag(tag: tag)
        }
    }
    
    func switchSplitViewControllerByTag(tag: Int) -> Void
    {
        if let splitViewController = self.contentViewController as? ApplicationSplitViewController {
            splitViewController.switchViewByTag(tag: tag)
        }
    }
}
