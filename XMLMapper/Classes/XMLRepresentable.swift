//
//  XMLRepresentable.swift
//  XMLMapper
//
//  Created by Giorgos Charitakis on 14/09/2017.
//
//

import Foundation

protocol XMLRepresentable {
    var xmlString: String { get }
}

extension Dictionary: XMLRepresentable {
}

extension Array: XMLRepresentable {
    var xmlString: String {
        guard let dictionaryArray = self as? [[String: Any]] else {
            return ""
        }
        return dictionaryArray.map({ $0.xmlString }).joined()
    }
}
