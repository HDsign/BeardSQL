//
//  SyntaxHighlighter.swift
//  BeardSql
//
//  Created by Swen van Zanten on 23-11-16.
//  Copyright © 2016 Swen van Zanten. All rights reserved.
//

import Cocoa

class SyntaxHighlighter
{
    var syntax: SyntaxProtocol!
    var textView: NSTextView!
    
    let colors = SyntaxSettings.shared
    
    init(syntax: SyntaxProtocol, textView: NSTextView)
    {
        self.syntax = syntax
        self.textView = textView
        
        self.highlight()
    }
    
    func highlight()
    {
        let code = NSString(string: self.textView.string!)
        let range = NSMakeRange(0, code.length)
        
        self.resetSyntaxHighlighting()
        
        self.highlightByWords(code: code, range: range)
        self.highlightByCharacters(code: code, range: range)
        self.highlightByLine(code: code, range: range)
    }
    
    ///
    // Color keywords
    ///
    private func highlightByWords(code: NSString, range: NSRange)
    {
        code.enumerateSubstrings(in: range, options: .byWords, using: { (substring, substringRange, _, _) in
            if (self.syntax.isKeyword(search: substring!)) {
                self.textView.textStorage?.addAttribute(
                    NSForegroundColorAttributeName,
                    value: self.colors.keywordColor,
                    range: substringRange
                )
            }
        })
    }
    
    ///
    // Color connectors and calculators.
    ///
    private func highlightByCharacters(code: NSString, range: NSRange)
    {
        code.enumerateSubstrings(in: range, options: .byComposedCharacterSequences, using: { (substring, substringRange, _, _) in
            if (self.syntax.isConnector(search: substring!)) {
                self.textView.textStorage?.addAttribute(NSForegroundColorAttributeName, value: self.colors.connectorColor, range: substringRange)
            }
            
            if (self.syntax.isCalculator(search: substring!)) {
                self.textView.textStorage?.addAttribute(NSForegroundColorAttributeName, value: self.colors.calculatorColor, range: substringRange)
            }
        })
    }
    
    ///
    // Color comments.
    ///
    private func highlightByLine(code: NSString, range: NSRange)
    {
        code.enumerateSubstrings(in: range, options: .byLines, using: { (substring, substringRange, _, _) in
            if (substring?.contains("-- "))! {
                let range = substring?.range(of: "-- ")
                let startIndex: Int = substring!.distance(from: substring!.startIndex, to: range!.lowerBound)
                let newsubstringRange = NSMakeRange(substringRange.location + startIndex, substringRange.length - startIndex)
                self.textView.textStorage?.addAttribute(NSForegroundColorAttributeName, value: self.colors.commentColor, range: newsubstringRange)
            }
        })
    }
    
    private func resetSyntaxHighlighting()
    {
        let area = NSMakeRange(0, (self.textView.textStorage?.length)!)
        
        self.textView.textStorage?.removeAttribute(NSForegroundColorAttributeName, range: area)
        self.textView.setTextColor(SyntaxSettings.shared.textColor, range: area)
    }
}
