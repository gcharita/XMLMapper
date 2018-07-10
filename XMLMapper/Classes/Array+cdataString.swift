//
//  Array+cdataString.swift
//  XMLMapper
//
//  Created by Giorgos Charitakis on 10/07/2018.
//

import Foundation

extension Array where Element == Data {
    var cdataString: String {
        return compactMap({ String(data: $0, encoding: .utf8) }).map({ "<![CDATA[\($0)]]>" }).joined(separator: "\n")
    }
}
