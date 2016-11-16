//
//  ContentViewController.swift
//  BeardSql
//
//  Created by Swen van Zanten on 06-11-16.
//  Copyright © 2016 Swen van Zanten. All rights reserved.
//

import Cocoa
import MySQL

class ContentViewController: NSViewController, SplitViewProtocol
{
    @IBOutlet weak var tableHeaderView: NSTableHeaderView!
    @IBOutlet weak var tableView: NSTableView!
    
    var content: [Model] = []

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        repo().changedTable(handler: { table in
            self.getData(table: table)
        })
    }
    
    func getData(table: String)
    {
        self.executeQuery(table: table)
        
        if self.content.count > 0 {
            self.removeAllColumns()
            
            self.createColumns()
            
            self.tableView.delegate = self
            self.tableView.dataSource = self
            
            self.tableView.reloadData()
        }
    }
    
    func executeQuery(table: String)
    {
        self.content = []
        
        let users = connector().execute("SELECT * FROM \(table)")
        
        for user in users {
            let model = Model()
            
            model.columns = user
            
            self.content.append(model)
        }
    }
    
    @IBAction func reloadData(_ sender: Any)
    {
        self.getData(table: repo().currentTable)
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
    
    func viewActivated() {
        //
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
            if let nice = value.string {
                cell.textField?.stringValue = nice
            } else {
                cell.textField?.stringValue = "NULL"
                cell.textField?.textColor = NSColor.lightGray
            }
            
            return cell
        }
        
        return nil
    }
}
