//
//  ConsoleViewController.swift
//  BeardSql
//
//  Created by Swen van Zanten on 16-11-16.
//  Copyright © 2016 Swen van Zanten. All rights reserved.
//

import Cocoa

class ConsoleViewController: NSViewController
{
    @IBOutlet weak var tableView: NSTableView!
    
    var console: Console?

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.view.window?.contentView?.wantsLayer = true
        self.view.window?.contentView?.layer?.masksToBounds = true
        
        self.console = container().get(name: "console") as? Console
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.console?.addedStatement(handler: { statement in
            self.tableView.reloadData()
        })
    }
    
}

extension ConsoleViewController: NSTableViewDataSource, NSTableViewDelegate
{
    func numberOfRows(in tableView: NSTableView) -> Int {
        return self.console?.numberOfStatements() ?? 0
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView?
    {
        if let column = tableColumn?.identifier {
            let cell = tableView.make(withIdentifier: "\(column)Cell", owner: self) as! NSTableCellView
            cell.textField?.stringValue = self.console?.getStatement(byRow: row)?.get(property: column, trim: "Column") ?? ""
            
            return cell
        }
        
        return nil
    }
}
