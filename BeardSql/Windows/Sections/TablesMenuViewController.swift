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
    
    var tables: [String] = []
    
    var filteredTables = [String]()

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.searchField.delegate = self

        self.listenToConnectionChanges()
        
        self.refreshTables()
    }
    
    @IBAction func refreshButtonClicked(_ sender: Any)
    {
        self.refreshTables()
    }
    
    func refreshTables()
    {
        if (!connector().hasConnection()) {
            return
        }

        self.resetTables()
        
        self.tables.append("Tables")
        
        for table in repo().getTables() {
            self.tables.append(table.getName())
        }
        
        self.filteredTables = self.tables
        
        self.outlineView.reloadData()
    }
    
    func resetTables()
    {
        self.tables.removeAll()
    }
    
    @IBAction func dropTableButtonClicked(_ sender: Any)
    {
        self.dropCurrentTable()
    }
    
    func dropCurrentTable()
    {
        repo().dropTable(table: repo().currentTable)
        
        self.refreshTables()
    }

    func listenToConnectionChanges()
    {
        NotificationCenter.default.addObserver(self, selector: #selector(databaseConnectionConnected), name: .DatabaseConnectionConnected, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(databaseConnectionDisconnected), name: .DatabaseConnectionDisconnected, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(databaseConnectionLost), name: .DatabaseConnectionLost, object: nil)
    }

    func databaseConnectionConnected(notification: NSNotification)
    {
        self.refreshTables()
    }

    func databaseConnectionDisconnected(notification: NSNotification)
    {
        print(notification)
    }

    func databaseConnectionLost(notification: NSNotification)
    {
        print(notification)
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
    
    func outlineViewSelectionDidChange(_ notification: Notification)
    {
        guard let outlineView = notification.object as? NSOutlineView else {
            return
        }
        
        
        repo().changeTable(table: outlineView.item(atRow: outlineView.selectedRow) as! String)
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
