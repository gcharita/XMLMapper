//
//  NSMutableDictionary+XMLParser.swift
//  XMLMapper
//
//  Created by Giorgos Charitakis on 19/10/2017.
//

import Foundation

extension NSMutableDictionary {
    var attributes: [String: String]? {
        let dictionary = self as? [String: Any]
        if let attributes = dictionary?[XMLParserConstant.Key.attributes] {
            return attributes as? [String: String]
        } else {
            var filteredDict = dictionary
            let filteredKeys = [XMLParserConstant.Key.comments, XMLParserConstant.Key.text, XMLParserConstant.Key.nodeName]
            filteredKeys.forEach({ filteredDict?.removeValue(forKey: $0) })
            filteredDict?.keys.forEach({ (key: String) in
                filteredDict?.removeValue(forKey: key)
                if key.hasPrefix(XMLParserConstant.attributePrefix) {
                    filteredDict?[key.substring(from: XMLParserConstant.attributePrefix.endIndex)] = dictionary?[key]
                }
            })
            return filteredDict?.isEmpty == false ? filteredDict as? [String: String] : nil
        }
    }
    
    var childNodes: [String: Any]? {
        var filteredDict = self as? [String: Any]
        let filteredKeys = [XMLParserConstant.Key.attributes, XMLParserConstant.Key.comments, XMLParserConstant.Key.text, XMLParserConstant.Key.nodeName]
        filteredKeys.forEach({ filteredDict?.removeValue(forKey: $0) })
        filteredDict?.keys.forEach({ (key: String) in
            if key.hasPrefix(XMLParserConstant.attributePrefix) {
                filteredDict?.removeValue(forKey: key)
            }
        })
        return filteredDict?.isEmpty == false ? filteredDict : nil
    }
    
    var comments: [String]? {
        return self[XMLParserConstant.Key.comments] as? [String]
    }
    
    var innerText: String? {
        let text = self[XMLParserConstant.Key.text]
        if let stringArray = text as? [String] {
            return stringArray.joined(separator: "\n")
        }
        return text as? String
    }
}
