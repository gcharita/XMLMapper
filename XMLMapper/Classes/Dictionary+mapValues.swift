//
//  Dictionary+mapValues.swift
//  XMLMapper
//
//  Created by Giorgos Charitakis on 17/06/2018.
//

import Foundation

// Backward compatibility for `mapValues(_:)` in Swift 3.0.
#if !swift(>=3.2)
extension Dictionary {
    func mapValues<T>(_ transform: (Dictionary.Value) throws -> T) rethrows -> [Dictionary.Key : T] {
        var result = [Key: T]()
        for (key, value) in self {
            result[key] = try transform(value)
        }
        return result
    }
}
#endif
