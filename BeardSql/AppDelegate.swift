//
//  AppDelegate.swift
//  BeardSql
//
//  Created by Swen van Zanten on 05-11-16.
//  Copyright © 2016 Swen van Zanten. All rights reserved.
//

import Cocoa
import BeardFramework

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate
{
    func applicationDidFinishLaunching(_ aNotification: Notification)
    {
        // Insert code here to initialize your application
        if #available(OSX 10.12.1, *) {
            NSApplication.shared().isAutomaticCustomizeTouchBarMenuItemEnabled = true
        }
        
        self.bootBeardFramework()
    }

    func applicationWillTerminate(_ aNotification: Notification)
    {
        // Insert code here to tear down your application
    }
    
    ///
    /// Boot up the beard framework!
    ///
    func bootBeardFramework()
    {
        ///
        /// Give all the service providers you want initialized.
        ///
        BeardContainer.shared.providers = [
            BeardServiceProvider.self,
            ExampleServiceProvider.self,
        ]
        
        ///
        /// Initialize all service providers.
        ///
        BeardContainer.shared.start()
    }
}

