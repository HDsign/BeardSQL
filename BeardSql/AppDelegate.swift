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
    private var beardContainer: BeardContainer? = nil
    
    override init() {
        super.init()
        
        self.bootBeardFramework()
    }
    
    func applicationDidFinishLaunching(_ aNotification: Notification)
    {
        // Insert code here to initialize your application
        if #available(OSX 10.12.1, *) {
            NSApplication.shared().isAutomaticCustomizeTouchBarMenuItemEnabled = true
        }
    }
    
    ///
    /// Boot up the beard framework!
    ///
    func bootBeardFramework()
    {
        self.beardContainer = BeardContainer()
        
        ///
        /// Give all the service providers you want initialized.
        ///
        self.beardContainer?.providers = [
            BeardServiceProvider.self,
            ConsoleServiceProvider.self,
            DatabaseServiceProvider.self,
        ]
        
        ///
        /// Initialize all service providers.
        ///
        self.beardContainer?.start()
    }
    
    func container() -> BeardContainer
    {
        return self.beardContainer!
    }

    func applicationWillTerminate(_ aNotification: Notification)
    {
        // Insert code here to tear down your application
    }
}

