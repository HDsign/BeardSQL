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
    @IBOutlet weak var scrollView: NSScrollView!
    @IBOutlet weak var tableHeaderView: NSTableHeaderView!
    @IBOutlet weak var tableView: NSTableView!
    @IBOutlet weak var busyIndicator: NSProgressIndicator!
    @IBOutlet weak var controlsStackView: NSStackView!
    
    var content: [Model] = []

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.scrollView.isHidden = true
        self.controlsStackView.isHidden = true
        
        self.busyIndicator.isHidden = true
        
        self.initEventListeners()
    }
    
    func initEventListeners()
    {
        repo().changedTable(handler: { table in
            self.getData(table: table)
        })
        
        repo().droppedTable(handler: { table in
            self.resetTable()
            
            self.scrollView.isHidden = true
            self.controlsStackView.isHidden = true
        })
    }
    
    func getData(table: String)
    {
        self.showBusyIndicator()
        
        self.resetTable()
        
        self.content = self.fetchContent(table: table)
        
        self.createColumns(table: table)
        
        if self.content.count > 0 {
            self.tableView.delegate = self
            self.tableView.dataSource = self
            
            self.tableView.reloadData()
        }
        
        self.hideBusyIndicator()
    }
    
    func fetchContent(table: String) -> [Model]
    {
        let results = connector().execute("SELECT * FROM \(table)")
        
        return results.map { row in
            let model = Model()
            model.columns = row
            
            return model
        }
    }
    
    @IBAction func reloadData(_ sender: Any)
    {
        self.getData(table: repo().currentTable)
    }
    
    func createColumns(table: String) -> Void
    {
        let columns = repo().getColumns(table: table)
        
        for column in columns {
            let tableColumn = NSTableColumn()
            tableColumn.title = column.field
            tableColumn.identifier = column.field
            
            self.tableView.addTableColumn(tableColumn)
        }
    }
    
    func resetTable() -> Void
    {
        self.scrollView.isHidden = false
        self.controlsStackView.isHidden = false
        
        self.removeAllContent()
        self.removeAllColumns()
    }
    
    func removeAllColumns() -> Void
    {
        for column in self.tableView.tableColumns {
            self.tableView.removeTableColumn(column)
        }
    }
    
    func removeAllContent() -> Void
    {
        self.content.removeAll()
    }
    
    func viewActivated() {
        //
    }
    
    func showBusyIndicator()
    {
        self.busyIndicator.isHidden = false
        self.busyIndicator.startAnimation(nil)
    }
    
    func hideBusyIndicator()
    {
        let when = DispatchTime.now()
        
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.busyIndicator.stopAnimation(nil)
            self.busyIndicator.isHidden = true
        }
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
        if (!self.content.indices.contains(row)) {
            return nil
        }
        
        let model = self.content[row]
        
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
