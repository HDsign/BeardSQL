//
//  QueryViewController.swift
//  BeardSql
//
//  Created by Swen van Zanten on 06-11-16.
//  Copyright © 2016 Swen van Zanten. All rights reserved.
//

import Cocoa
//import Fragaria
import BeardFramework

class QueryViewController: NSViewController, SplitViewProtocol
{
    @IBOutlet weak var editor: NSTextView!
    @IBOutlet weak var tableView: NSTableView!
    
    var content: [Model] = []

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.editor.isRichText = false
        self.editor.font = NSFont(name: "Menlo", size: 15)
        self.editor.backgroundColor = NSColor.darkGray
        self.editor.textColor = NSColor.lightGray
        self.editor.lnv_setUpLineNumberView()
        
        self.editor.string = "SELECT * FROM users"
        
        let area = NSMakeRange(0, (self.editor.textStorage?.length)!)
        self.editor.textStorage?.removeAttribute(NSForegroundColorAttributeName, range: area)
        self.editor.textStorage?.addAttribute(NSForegroundColorAttributeName, value: NSColor.blue, range: area)
    }
    
    func viewActivated()
    {
        
    }
    
    @IBAction func runQuery(_ sender: Any)
    {
        self.run()
    }
    
    func run()
    {
        self.content.removeAll()
        self.removeAllColumns()
        
        let results = connector().executeOrdered(self.editor.string!)
        
        self.content = results.map { row in
            let model = Model()
            model.columns = row
            
            return model
        }
        
        let firstRow = content.first
        
        for column in (firstRow?.columns) ?? [] {
            let tableColumn = NSTableColumn()
            tableColumn.title = column.name
            tableColumn.identifier = column.name
            
            self.tableView.addTableColumn(tableColumn)
        }
        
        self.tableView.reloadData()
    }
    
    func removeAllColumns() -> Void
    {
        for column in self.tableView.tableColumns {
            self.tableView.removeTableColumn(column)
        }
    }
}

extension QueryViewController: NSTableViewDelegate, NSTableViewDataSource
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
        
        if let value = model.get(name: column!) {
            let cell = tableView.make(withIdentifier: "tableCellView", owner: self) as! NSTableCellView
            if let nice = value.value.string {
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
