//
//  XMLRepresentable.swift
//  XMLMapper
//
//  Created by Giorgos Charitakis on 14/09/2017.
//
//

import Foundation
import XMLDictionary

protocol XMLRepresentable {
    var xmlString: String { get }
}

extension Dictionary: XMLRepresentable {
    var xmlString: String {
        return (self as NSDictionary).xmlString
    }
}

extension Array: XMLRepresentable {
    var xmlString: String {
        guard let dictionaryArray = self as? [[String: Any]] else {
            return ""
        }
        return dictionaryArray.map({ $0.xmlString }).joined()
    }
}
