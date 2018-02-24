//
//  InconsolataFont.swift
//  Example
//
//  Created by Peera Kerdkokaew on 25/2/18.
//  Copyright © 2018 Peera Kerdkokaew. All rights reserved.
//

import UIKit
import FontInjector

enum InconsolataFont: String, FontPackage {
    
    case regular = "Inconsolata-Regular"
    case bold = "Inconsolata-Bold"
    
    var fontPath: String {
        return "Fonts/Inconsolata"
    }
    
    var fontExtension: FontExtension {
        return .ttf
    }
    
}
