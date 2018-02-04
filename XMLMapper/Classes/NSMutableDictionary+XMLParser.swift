//
//  NSMutableDictionary+XMLParser.swift
//  XMLMapper
//
//  Created by Giorgos Charitakis on 19/10/2017.
//

import Foundation

extension NSMutableDictionary {
    var attributes: [String: String]? {
        return (self as Dictionary).attributes
    }
    
    var childNodes: [String: Any]? {
        return (self as Dictionary).childNodes
    }
    
    var comments: [String]? {
        return (self as Dictionary).comments
    }
    
    var innerText: String? {
        return (self as Dictionary).innerText
    }
}
