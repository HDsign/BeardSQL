//
//  QueryViewController.swift
//  BeardSQL
//
//  Created by Swen van Zanten on 03-08-16.
//  Copyright © 2016 Swen van Zanten. All rights reserved.
//

import Cocoa
import ACEViewSwift
import MySqlSwiftNative

class QueryViewController: NSViewController, NSTableViewDataSource
{

    @IBOutlet weak var queryEditor: ACEView!
    @IBOutlet weak var queryTable: NSTableView!
    
    let con = MySQL.Connection()
    let host = "127.0.0.1"
    let username = "root"
    let password = "root"
    let db_name = "example"
    
    var items: [MySQL.Row]?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.connectDatabase()
        self.initEditor()
        self.initTable()
    }
    
    private func connectDatabase()
    {
        do{
            try self.con.open(self.host, user: self.username, passwd: self.password)
            try self.con.use(db_name)
        } catch (let e) {
            print(e)
        }
    }
    
    private func initEditor()
    {
        self.queryEditor.onReady = { [unowned self] in
            self.queryEditor.string = "select * from role_extras"
            self.queryEditor.theme = ACETheme.CrimsonEditor
            self.queryEditor.mode  = .SQL
            self.queryEditor.basicAutoCompletion = true
            self.queryEditor.liveAutocompletion = true
        }
        
        NSNotificationCenter.defaultCenter().addObserverForName("runQueryPushed", object: nil, queue: NSOperationQueue.mainQueue()) { notification in
            self.runQuery()
        }
    }
    
    private func initTable()
    {
        for column in self.queryTable.tableColumns {
            self.queryTable.removeTableColumn(column)
        }
    }
    
    private func runQuery()
    {
        do{
            // open a new connection
            let result = try self.con.query(queryEditor.string)
            let rows = try result.readAllRows()
            
            //print(rows)
            if let items = rows?.first {
                self.items = items
                
                self.initTable()
                
                for column in (self.items?.first)! {
                    let col = NSTableColumn(identifier: column.0)
                    col.title = column.0
                    self.queryTable.addTableColumn(col)
                }
                
                dispatch_async(dispatch_get_main_queue(), {
                    self.queryTable.reloadData()
                })
                
            }
            
            print(items)
        } catch (let e) {
            let alert = NSAlert()
            alert.addButtonWithTitle("Ok")
            alert.messageText = String(e)
            alert.alertStyle = .WarningAlertStyle
            alert.runModal()
        }
    }
    
    func numberOfRowsInTableView(tableView: NSTableView) -> Int
    {
        if let items = self.items {
            return items.count
        }
        
        return 0
    }
    
    func tableView(tableView: NSTableView, objectValueForTableColumn tableColumn: NSTableColumn?, row: Int) -> AnyObject?
    {
        if let item = self.items {
            let rowItem = item[row]
            if let value = rowItem[(tableColumn?.identifier)!] {
                return String(value)
            }
        }
        
        return ""
    }
}
