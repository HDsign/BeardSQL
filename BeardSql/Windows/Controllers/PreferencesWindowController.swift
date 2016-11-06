//
//  PreferencesWindowController.swift
//  BeardSql
//
//  Created by Swen van Zanten on 06-11-16.
//  Copyright © 2016 Swen van Zanten. All rights reserved.
//

import Cocoa

class PreferencesWindowController: NSWindowController
{
    @IBOutlet weak var generalViewController: NSView?
    @IBOutlet weak var fontsAndColorsViewController: NSView?
    
    var viewControllers: [NSView] = []
    
    override func windowDidLoad()
    {
        super.windowDidLoad()
        
        self.viewControllers.append(generalViewController!)
        self.viewControllers.append(fontsAndColorsViewController!)
        
        self.switchViewByTag(tag: 0)
    }
    
    @IBAction func toolbarAction(_ sender: Any)
    {
        if let tag = (sender as AnyObject).tag {
            self.switchViewByTag(tag: tag)
        }
    }
    
    func switchViewByTag(tag: Int) -> Void
    {
        self.setContentView(view: self.viewControllers[tag])
    }

    func setContentView(view: NSView) -> Void
    {
        self.window?.contentView = view
    }
    
}
