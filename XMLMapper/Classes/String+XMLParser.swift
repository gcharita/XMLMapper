//
//  String+XMLParser.swift
//  XMLMapper
//
//  Created by Giorgos Charitakis on 19/10/2017.
//

import Foundation

extension String {
    public var xmlEncodedString: String {
        return self.replacingOccurrences(of: "&", with: "&amp;")
            .replacingOccurrences(of: "<", with: "&lt;")
            .replacingOccurrences(of: ">", with: "&gt;")
            .replacingOccurrences(of: "\"", with: "&quot;")
            .replacingOccurrences(of: "\'", with: "&apos;")
    }
}
