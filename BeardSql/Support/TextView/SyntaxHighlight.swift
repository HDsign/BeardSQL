//
//  NSTextView+Syntax.swift
//  BeardSqlEditor
//
//  Created by Swen van Zanten on 22-11-16.
//  Copyright © 2016 Swen van Zanten. All rights reserved.
//

import Cocoa

extension NSTextView
{
    func enableSyntaxHighlighting(language: String)
    {
        self.highlight()
        self.smartInsertDeleteEnabled = false
        self.isAutomaticQuoteSubstitutionEnabled = false
        self.isAutomaticDashSubstitutionEnabled = false
        self.backgroundColor = SyntaxSettings.shared.backgroundColor
        self.insertionPointColor = SyntaxSettings.shared.insertionPointColor
        
        NotificationCenter.default.addObserver(self, selector: #selector(syntaxTextDidChange), name: NSNotification.Name.NSTextDidChange, object: self)
    }
    
    func highlight()
    {
        let nsText = NSString(string: self.string!)
        let textRange = NSMakeRange(0, nsText.length)
        
        let syntax = MySQLSyntax()
        let colors = SyntaxSettings.shared
        
        self.resetSyntaxHighlighting()
        
        // Color keywords
        nsText.enumerateSubstrings(in: textRange, options: .byWords, using: { (substring, substringRange, _, _) in
            if (syntax.isKeyword(search: substring!)) {
                self.textStorage?.addAttribute(NSForegroundColorAttributeName, value: colors.keywordColor, range: substringRange)
            }
        })
        
        // Color connectors and calculators
        nsText.enumerateSubstrings(in: textRange, options: .byComposedCharacterSequences, using: { (substring, substringRange, _, _) in
            if (syntax.isConnector(search: substring!)) {
                self.textStorage?.addAttribute(NSForegroundColorAttributeName, value: colors.connectorColor, range: substringRange)
            }
            
            if (syntax.isCalculator(search: substring!)) {
                self.textStorage?.addAttribute(NSForegroundColorAttributeName, value: colors.calculatorColor, range: substringRange)
            }
        })
        
        // Color comments.
        nsText.enumerateSubstrings(in: textRange, options: .byLines, using: { (substring, substringRange, _, _) in
            if (substring?.contains("-- "))! {
                let range = substring?.range(of: "-- ")
                let startIndex: Int = substring!.distance(from: substring!.startIndex, to: range!.lowerBound)
                let newsubstringRange = NSMakeRange(substringRange.location + startIndex, substringRange.length)
                self.textStorage?.addAttribute(NSForegroundColorAttributeName, value: colors.commentColor, range: newsubstringRange)
            }
        })
    }
    
    func syntaxTextDidChange(notification: NSNotification)
    {
        self.highlight()
    }
    
    private func resetSyntaxHighlighting()
    {
        let area = NSMakeRange(0, (self.textStorage?.length)!)
        
        self.textStorage?.removeAttribute(NSForegroundColorAttributeName, range: area)
        self.setTextColor(SyntaxSettings.shared.textColor, range: area)
    }
}
