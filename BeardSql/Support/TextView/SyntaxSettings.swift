//
//  SyntaxSettings.swift
//  BeardSqlEditor
//
//  Created by Swen van Zanten on 22-11-16.
//  Copyright © 2016 Swen van Zanten. All rights reserved.
//

import Cocoa

class SyntaxSettings
{
    static let shared = SyntaxSettings()
    
    var backgroundColor: NSColor = #colorLiteral(red: 0.3360741083, green: 0.3380373691, blue: 0.3532207465, alpha: 1)
    var textColor: NSColor = NSColor.white
    var keywordColor: NSColor = #colorLiteral(red: 0.2964815373, green: 0.8341991305, blue: 0.6071883276, alpha: 1)
    var connectorColor: NSColor = #colorLiteral(red: 0.5711379248, green: 0.7899073361, blue: 0.8199804925, alpha: 1)
    var calculatorColor: NSColor = #colorLiteral(red: 0.3898568942, green: 0.8341991305, blue: 0.7605380137, alpha: 1)
    var commentColor: NSColor = #colorLiteral(red: 0.5609186484, green: 0.5659616623, blue: 0.5886113715, alpha: 1)
    var insertionPointColor: NSColor = NSColor.white
    
    var rulerBackgroundColor: NSColor = #colorLiteral(red: 0.2498163819, green: 0.2513880055, blue: 0.2635425567, alpha: 1)
}
