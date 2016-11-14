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
    @IBOutlet weak var outlineView: NSOutlineView!
    
    let tables: [String] = [
        "Tables",
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
    
    var filteredTables = [String]()

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.filteredTables = self.tables
    
        self.searchField.delegate = self
    }
    
}

extension TablesMenuViewController: NSOutlineViewDelegate, NSOutlineViewDataSource
{
    func outlineView(_ outlineView: NSOutlineView, numberOfChildrenOfItem item: Any?) -> Int
    {
        return self.filteredTables.count
    }
    
    func outlineView(_ outlineView: NSOutlineView, isItemExpandable item: Any) -> Bool
    {
        return item as! String == "Tables"
    }
    
    func outlineView(_ outlineView: NSOutlineView, child index: Int, ofItem item: Any?) -> Any
    {
        return self.filteredTables[index]
    }
    
    func outlineView(_ outlineView: NSOutlineView, viewFor tableColumn: NSTableColumn?, item: Any) -> NSView?
    {
        if (item as! String == "Tables") {
            let cell = outlineView.make(withIdentifier: "HeaderCell", owner: self) as! NSTableCellView
            
            cell.textField?.stringValue = (item as! String).uppercased()
            
            return cell
        }
        
        let table = item as! String
        
        let cell = outlineView.make(withIdentifier: "DataCell", owner: self) as! NSTableCellView
        
        cell.textField?.stringValue = table
        cell.imageView?.image = NSImage(named: "NSStatusAvailable")
        
        return cell
    }
}

extension TablesMenuViewController: NSSearchFieldDelegate
{
    override func controlTextDidChange(_ obj: Notification)
    {
        self.filterTable(search: self.searchField.stringValue)
    }
    
    func filterTable(search: String) -> Void
    {
        self.filteredTables = self.tables.filter { item in
            for l in search.characters {
                if (!item.lowercased().contains(l.description.lowercased())) {
                    return false
                }
            }
            
            return true
        }
        
        self.outlineView.reloadData()
    }
}

