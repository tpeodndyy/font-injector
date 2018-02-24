//
//  RawRepresentable+FontInjector.swift
//  FontInjector
//
//  Created by Peera Kerdkokaew on 25/2/18.
//  Copyright © 2018 Peera Kerdkokaew. All rights reserved.
//

import UIKit

public extension RawRepresentable where Self: Hashable {
    
    public static var allCases: AnySequence<Self> {
        typealias S = Self
        return AnySequence { () -> AnyIterator<S> in
            var raw = 0
            return AnyIterator {
                let current : Self = withUnsafePointer(to: &raw) { $0.withMemoryRebound(to: S.self, capacity: 1) { $0.pointee } }
                guard current.hashValue == raw else { return nil }
                raw += 1
                print("\(current)")
                return current
            }
        }
    }
    
}
