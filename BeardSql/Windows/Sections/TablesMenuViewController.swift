//
//  TablesMenuViewController.swift
//  BeardSql
//
//  Created by Swen van Zanten on 11-11-16.
//  Copyright © 2016 Swen van Zanten. All rights reserved.
//

import Cocoa

class TablesMenuViewController: NSViewController
{
    
    @IBOutlet weak var searchField: NSSearchField!
    @IBOutlet weak var tableView: NSTableView!
    
    var tables: [String] = [
        "database_migrations",
        "dns_records",
        "domain_records",
        "domains",
        "hosting_cache",
        "hosting_plans",
        "hosting_servers",
        "logs",
        "mail_templaces",
        "mail_types",
        "users",
    ]

    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do view setup here.
    
        self.searchField.delegate = self
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
}

extension TablesMenuViewController: NSTableViewDelegate, NSTableViewDataSource
{
    func numberOfRows(in tableView: NSTableView) -> Int
    {
        return tables.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView?
    {
        let table = self.tables[row]
        
        let cell = tableView.make(withIdentifier: "databaseTableCell", owner: self) as! NSTableCellView
        
        cell.textField?.stringValue = table
        cell.imageView?.image = NSImage(named: "Triggers")
        
        return cell
    }
}

extension TablesMenuViewController: NSSearchFieldDelegate
{
    func searchFieldDidStartSearching(_ sender: NSSearchField)
    {
    }
}
