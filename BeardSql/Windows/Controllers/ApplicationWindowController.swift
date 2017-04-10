//
//  ApplicationWindowController.swift
//  BeardSql
//
//  Created by Swen van Zanten on 05-11-16.
//  Copyright © 2016 Swen van Zanten. All rights reserved.
//

import Cocoa
import Dispatch

class ApplicationWindowController: NSWindowController
{
    @IBOutlet weak var connectionLabel:       NSTextField!
    @IBOutlet weak var connectionStatusImage: NSImageView!

    override func windowDidLoad()
    {
        super.windowDidLoad()

        self.bootstrapping()

        self.listenToConnectionChanges()

        self.showConnectionsView()
    }

    func bootstrapping() -> Void
    {
        self.window?.titleVisibility = .hidden
        self.window?.toolbar?.displayMode = .iconOnly

        self.window?.contentView?.wantsLayer = true
        self.window?.contentView?.layer?.masksToBounds = true

        self.window?.miniwindowTitle = "BeardSql"
    }

    @IBAction func toolbarAction(_ sender: NSToolbarItem)
    {
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

    func listenToConnectionChanges()
    {
        NotificationCenter.default.addObserver(self, selector: #selector(databaseConnectionConnected),
                                               name: .DatabaseConnectionConnected, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(databaseConnectionDisconnected),
                                               name: .DatabaseConnectionDisconnected, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(databaseConnectionLost),
                                               name: .DatabaseConnectionLost, object: nil)
    }

    func databaseConnectionConnected(notification: NSNotification)
    {
        let host:     String = connector().host
        let database: String = (connector().database == "") ? "No database selected" : connector().database

        connectionLabel.stringValue = "\(host): \(database)"
        connectionStatusImage.image = NSImage(named: NSImageNameStatusAvailable)
    }

    func databaseConnectionDisconnected(notification: NSNotification)
    {
        print(notification)
    }

    func databaseConnectionLost(notification: NSNotification)
    {
        print(notification)
    }

    func showConnectionsView()
    {
        DispatchQueue.main.async
        {
            let storyboard = NSStoryboard(name: "Application", bundle: nil)
            let controller = storyboard.instantiateController(withIdentifier: "connectionsView")
            self.contentViewController?.presentViewControllerAsSheet(controller as! NSViewController)
        }
    }
}
