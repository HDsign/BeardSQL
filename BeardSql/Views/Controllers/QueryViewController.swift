//
//  QueryViewController.swift
//  BeardSql
//
//  Created by Swen van Zanten on 06-11-16.
//  Copyright © 2016 Swen van Zanten. All rights reserved.
//

import Cocoa
import ACEViewSwift
import Fragaria

class QueryViewController: NSViewController, SplitViewProtocol
{
    @IBOutlet weak var aceView: ACEView!
    @IBOutlet weak var fragaria: MGSFragariaView!

    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    func loadAceView() -> Void
    {
        // Some text content
        let html = "select * from `relaties`"
        
        // onReady() is a convenience closure for configuring
        // the ACEView right after it has been finished loading
        
        /*
        self.aceView.onReady = { [unowned self] in
            self.aceView.string              = html
            self.aceView.mode                = ACEMode.sql
            self.aceView.theme               = ACETheme.tomorrow
            self.aceView.keyboardHandler     = ACEKeyboardHandler.ace
            self.aceView.showPrintMargin     = true
            self.aceView.printMarginColumn   = 120
            self.aceView.basicAutoCompletion = true
            self.aceView.liveAutocompletion  = true
            self.aceView.snippets            = true
            self.aceView.emmet               = true
            self.aceView.borderType          = .noBorder
        }
        */
        
        self.fragaria.autoCompleteDelay = 0.2
        self.fragaria.autoCompleteEnabled = true
        self.fragaria.autoCompleteWithKeywords = true
        self.fragaria.highlightsCurrentLine = true
        self.fragaria.syntaxDefinitionName = "MySQL"
        self.fragaria.showsSyntaxErrors = true
        self.fragaria.textView.string = html
    }
    
    func focusAceView() -> Void
    {
        // self.aceView.focus()
    }
    
    func viewActivated()
    {
        self.loadAceView()
    }
    
    @IBAction func runQuery(_ sender: Any)
    {
        let alert = NSAlert()
        alert.alertStyle = .informational
        alert.messageText = "The query you want to run is awesome! But hé did you know you can archive these queries?"
        alert.informativeText = "Okay if you hate these kind of messages?? No problem me too :D click the flag down below to ignore them forever!"
        alert.showsSuppressionButton = true
        alert.icon = NSImage(named: "NSInfo")
        alert.addButton(withTitle: "Ok")
        alert.addButton(withTitle: "Cancel")
        alert.runModal()
    }
}
