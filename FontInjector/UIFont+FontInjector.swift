//
//  UIFont+FontInjector.swift
//  FontInjector
//
//  Created by Peera Kerdkokaew on 25/2/18.
//  Copyright © 2018 Peera Kerdkokaew. All rights reserved.
//

import UIKit

/**
 
 Wrapper of `UIFontTextStyle` for iOS9 competible to allow `largeTitle`
 to be represented. This enumeration will be used instead of the system
 old for `FontInjectable` methods.
 
 */
public enum FontTextStyle: Int {
    
    case largeTitle = 0
    case title1
    case title2
    case title3
    case headline
    case body
    case callout
    case subheadline
    case footnote
    case caption1
    case caption2
    
    internal var systemFontTextStyle: UIFontTextStyle? {
        return [FontTextStyle.title1: UIFontTextStyle.title1,
                FontTextStyle.title2: UIFontTextStyle.title2,
                FontTextStyle.title3: UIFontTextStyle.title3,
                FontTextStyle.headline: UIFontTextStyle.headline,
                FontTextStyle.body: UIFontTextStyle.body,
                FontTextStyle.callout: UIFontTextStyle.callout,
                FontTextStyle.subheadline: UIFontTextStyle.subheadline,
                FontTextStyle.footnote: UIFontTextStyle.footnote,
                FontTextStyle.caption1: UIFontTextStyle.caption1,
                FontTextStyle.caption2: UIFontTextStyle.caption2][self]
    }
    
    /**
     Get `preferredFont` value font size.
     */
    public var dynamicPointSize: CGFloat {
        if let systemFontTextStyle = systemFontTextStyle {
            return UIFont.preferredFont(forTextStyle: systemFontTextStyle).pointSize
        } else if self == .largeTitle {
            let title1FontSize = UIFont.preferredFont(forTextStyle: .title1).pointSize
            if let title1SizingMapper = [38, 43, 48, 53, 58].index(of: title1FontSize) {
                return [44, 48, 52, 56, 60][title1SizingMapper]
            }
            return 52
        }
        return 16
    }
    
}

public extension UIFont {
    
    public class func dynamicFont<T: FontPackage>(style: FontTextStyle,
                                                  weight: UIFont.Weight = .regular,
                                                  ofFont font: T.Type? = nil) -> UIFont {
        return UIFont.staicFont(ofSize: style.dynamicPointSize, weight: weight)
    }
    
    internal class func staicFont(ofSize size: CGFloat, weight: UIFont.Weight) -> UIFont {
        if let font = FontInjector.font(ofSize: size, weight: weight) {
            return font
        }
        return UIFont.systemFont(ofSize: size, weight: weight)
    }
    
}
