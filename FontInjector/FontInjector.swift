//
//  FontInjector.swift
//  FontInjector
//
//  Created by Peera Kerdkokaew on 22/2/18.
//  Copyright © 2018 Peera Kerdkokaew. All rights reserved.
//

import UIKit

public enum FontExtension: String {
    case ttf = ".ttf"
    case otf = ".otf"
}

public protocol FontPackage: Hashable, RawRepresentable {
    
    static var familyName: String { get }
    
    var fileName: String { get }
    var fontPath: String { get }
    var fontExtension: FontExtension { get }
    
    static func register(fromBundle bundle: Bundle?)
    static func dynamicFont(textStyle: FontTextStyle, weight: UIFont.Weight) -> UIFont
    static func font(ofSize size: CGFloat, weight: UIFont.Weight) -> UIFont
}

public extension FontPackage {
    
    static func register(fromBundle bundle: Bundle?) {
        FontInjector.register(fontPackage: Self.self, fromBundle: bundle)
    }
    
    static func dynamicFont(textStyle: FontTextStyle, weight: UIFont.Weight = .regular) -> UIFont {
        return UIFont.dynamicFont(style: textStyle, weight: weight, ofFont: Self.self)
    }
    
    static func font(ofSize size: CGFloat, weight: UIFont.Weight = .regular) -> UIFont {
        return UIFont.staicFont(ofSize: size, weight: weight)
    }
}

public extension FontPackage where Self.RawValue == String {

    var fileName: String {
        return rawValue
    }
    
    static var familyName: String {
        return "\(self)"
    }
    
}

public class FontInjector: NSObject {
    
    public static var lastestRegisterFontFamilyName: String?
    public static var registeredFont: [String: [UIFont.Weight : String]] = [:]
    
    static internal func font(ofSize size: CGFloat, weight: UIFont.Weight = .regular) -> UIFont? {
        guard let registeredFontName = lastestRegisterFontFamilyName,
              let fonts = registeredFont[registeredFontName],
              fonts.values.count > 0 else {
            return nil
        }
        let postScriptedName = fonts[weight] ?? fonts[.regular] ?? Array(fonts.values)[0]
        return UIFont(name: postScriptedName, size: size)
    }
    
    static func register<T: FontPackage>(fontPackage: T.Type, fromBundle bundle: Bundle?) {
        for font in fontPackage.allCases {
            if let fontWeightName = "\(font)".split(separator: ".").last {
                for fontWeight in UIFont.Weight.all {
                    if let key = fontWeight.key, key == fontWeightName,
                        let path = (bundle ?? Bundle.main).url(forResource: font.fontPath + "/" + font.fileName,
                                                               withExtension: font.fontExtension.rawValue),
                        let fontData = try? (Data(contentsOf: path) as CFData),
                        let dataProvider = CGDataProvider(data: fontData),
                        let cgFont = CGFont(dataProvider) {
                        var error: Unmanaged<CFError>?
                        if CTFontManagerRegisterGraphicsFont(cgFont, &error),
                            let fontName = cgFont.postScriptName as String? {
                            if registeredFont[fontPackage.familyName] == nil {
                                registeredFont[fontPackage.familyName] = [:]
                            }
                            registeredFont[fontPackage.familyName]?[fontWeight] = fontName
                        }
                    }
                }
            }
        }
        lastestRegisterFontFamilyName = fontPackage.familyName
    }
}


