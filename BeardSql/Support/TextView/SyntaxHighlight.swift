//
//  NSTextView+Syntax.swift
//  BeardSqlEditor
//
//  Created by Swen van Zanten on 22-11-16.
//  Copyright © 2016 Swen van Zanten. All rights reserved.
//

import Cocoa
import ObjectiveC

var SyntaxHighlighterViewAssocObjKey: UInt8 = 0

extension NSTextView
{
    var syntaxHighlighter: SyntaxHighlighter {
        get {
            return objc_getAssociatedObject(self, &SyntaxHighlighterViewAssocObjKey) as! SyntaxHighlighter
        }
        set {
            objc_setAssociatedObject(self, &SyntaxHighlighterViewAssocObjKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func enableSyntaxHighlighting(syntax: SyntaxProtocol)
    {
        self.syntaxHighlighter = SyntaxHighlighter(syntax: syntax, textView: self)
        self.registerListeners()
    }
    
    private func registerListeners()
    {
        NotificationCenter.default.addObserver(self, selector: #selector(syntaxTextDidChange), name: NSNotification.Name.NSTextDidChange, object: self)
    }
    
    func syntaxTextDidChange(notification: NSNotification)
    {
        self.syntaxHighlighter.highlight()
    }
}
