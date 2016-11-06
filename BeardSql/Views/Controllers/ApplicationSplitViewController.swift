//
//  ApplicationSplitViewController.swift
//  BeardSql
//
//  Created by Swen van Zanten on 06-11-16.
//  Copyright © 2016 Swen van Zanten. All rights reserved.
//

import Cocoa

class ApplicationSplitViewController: NSSplitViewController
{
    var viewControllerNames: [String] = [
        "structureViewController",
        "contentViewController",
        "relationsViewController",
        "triggersViewController",
        "tableInfoViewController",
        "queryViewController"
    ]
    
    var viewControllers: [NSViewController] = []
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.createAllViewControllers().switchViewByTag(tag: 0)
    }
    
    func createAllViewControllers() -> ApplicationSplitViewController
    {
        for identifier in viewControllerNames {
            let viewController = self.storyboard?.instantiateController(withIdentifier: identifier)
            
            self.viewControllers.append(viewController as! NSViewController)
        }
        
        return self
    }
    
    func switchViewByTag(tag: Int) -> Void
    {
        if (self.splitViewItems.count > 1) {
            self.removeLastSplitView()
        }
        
        let viewController = self.viewControllers[tag]
        
        self.addSplitViewItem(NSSplitViewItem(viewController: viewController))
        
        if let view = viewController as? SplitViewProtocol {
            view.viewActivated()
        }
    }
    
    func removeLastSplitView() -> Void
    {
        let lastItem = self.splitViewItems.last
        
        self.removeSplitViewItem(lastItem!)
    }
}
