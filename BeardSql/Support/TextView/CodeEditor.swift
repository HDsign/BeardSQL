//
//  CodeEditor.swift
//  BeardSql
//
//  Created by Swen van Zanten on 23-11-16.
//  Copyright © 2016 Swen van Zanten. All rights reserved.
//

import Cocoa

extension NSTextView
{
    func enableCodeEditor(language: String)
    {
        self.isRichText = false
        self.font = NSFont(name: "Menlo", size: 15)
        self.textContainerInset = NSMakeSize(5, 5)
        
        self.smartInsertDeleteEnabled = false
        self.isContinuousSpellCheckingEnabled = false
        self.isAutomaticSpellingCorrectionEnabled = false
        self.isGrammarCheckingEnabled = false
        
        self.isAutomaticQuoteSubstitutionEnabled = false
        self.isAutomaticDashSubstitutionEnabled = false
        
        self.backgroundColor = SyntaxSettings.shared.backgroundColor
        self.insertionPointColor = SyntaxSettings.shared.insertionPointColor
        
        self.enableLineNumbers()
        self.enableSyntaxHighlighting(syntax: MySQLSyntax())
    }
}
