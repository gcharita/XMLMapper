//
//  XMLURLTransform.swift
//  XMLMapper
//
//  Created by Giorgos Charitakis on 14/09/2017.
//
//

import Foundation

open class XMLURLTransform: XMLTransformType {
    public typealias Object = URL
    public typealias XML = String
    private let shouldEncodeURLString: Bool
    private let allowedCharacterSet: CharacterSet
    
    /**
         Initializes the URLTransform with an option to encode URL strings before converting them to an NSURL
         - parameter shouldEncodeUrlString: when true (the default) the string is encoded before passing
         to `NSURL(string:)`
         - returns: an initialized transformer
     */
    public init(shouldEncodeURLString: Bool = true, allowedCharacterSet: CharacterSet = .urlQueryAllowed) {
        self.shouldEncodeURLString = shouldEncodeURLString
        self.allowedCharacterSet = allowedCharacterSet
    }
    
    open func transformFromXML(_ value: Any?) -> Object? {
        guard let URLString = value as? String else { return nil }
        
        if !shouldEncodeURLString {
            return URL(string: URLString)
        }
        
        guard let escapedURLString = URLString.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) else {
            return nil
        }
        return URL(string: escapedURLString)
    }
    
    open func transformToXML(_ value: URL?) -> XML? {
        if let URL = value {
            return URL.absoluteString
        }
        return nil
    }
}
