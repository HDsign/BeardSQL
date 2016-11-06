//
//  QueryViewController.swift
//  BeardSql
//
//  Created by Swen van Zanten on 06-11-16.
//  Copyright © 2016 Swen van Zanten. All rights reserved.
//

import Cocoa
import ACEViewSwift

class QueryViewController: NSViewController, SplitViewProtocol
{
    @IBOutlet weak var aceView: ACEView!

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
        
        self.aceView.onReady = { [unowned self] in
            self.aceView.string = html
            self.aceView.mode = ACEMode.sql
            self.aceView.theme = ACETheme.tomorrow
            self.aceView.keyboardHandler = ACEKeyboardHandler.ace
            self.aceView.showPrintMargin = true
            self.aceView.showInvisibles = false
            self.aceView.basicAutoCompletion = true
            self.aceView.liveAutocompletion = true
            self.aceView.snippets = true
            self.aceView.emmet = true
            self.aceView.borderType = .noBorder
        }
    }
    
    func focusAceView() -> Void
    {
        self.aceView.focus()
    }
    
    func viewActivated()
    {
        self.loadAceView()
    }
}
