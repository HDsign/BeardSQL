//
//  ContentViewController.swift
//  BeardSql
//
//  Created by Swen van Zanten on 06-11-16.
//  Copyright © 2016 Swen van Zanten. All rights reserved.
//

import Cocoa

class ContentViewController: NSViewController, SplitViewProtocol
{
    @IBOutlet weak var tableHeaderView: NSTableHeaderView!
    @IBOutlet weak var tableView: NSTableView!
    
    let content: [Model] = [
        Model(id: 1, name: "John Doe"),
        Model(id: 2, name: "Jane Doe"),
        Model(id: 23, name: "Swen van Zanten")
    ]

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.removeAllColumns()
        
        self.createColumns()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.reloadData()
    }
    
    func removeAllColumns() -> Void
    {
        for column in self.tableView.tableColumns {
            self.tableView.removeTableColumn(column)
        }
    }
    
    func createColumns() -> Void
    {
        let data = content.first
        
        for column in (data?.columns)! {
            let tableColumn = NSTableColumn()
            tableColumn.title = column.key
            tableColumn.identifier = column.key
            
            self.tableView.addTableColumn(tableColumn)
        }
    }
    
    func viewActivated()
    {
        print("contentView!!")
    }
}

extension ContentViewController: NSTableViewDelegate, NSTableViewDataSource
{
    func numberOfRows(in tableView: NSTableView) -> Int
    {
        return content.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView?
    {
        let model = content[row]
        
        let column = tableColumn?.identifier
        
        if let value = model.columns?[column!] {
            let cell = tableView.make(withIdentifier: "tableCellView", owner: self) as! NSTableCellView
            cell.textField?.stringValue = String(describing: value)
            
            return cell
        }
        
        return nil
    }
}
