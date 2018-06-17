//
//  Sequence+compactMap.swift
//  XMLMapper
//
//  Created by Giorgos Charitakis on 17/06/2018.
//

import Foundation

// Backward compatibility for `compactMap(_:)` in Swift 4.0 and below.
#if !swift(>=4.1)
extension Sequence {
    public func compactMap<ElementOfResult>(_ transform: (Iterator.Element) throws -> ElementOfResult?) rethrows -> [ElementOfResult] {
        return try flatMap(transform)
    }
}
#endif
