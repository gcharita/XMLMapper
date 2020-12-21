//
//  XMLCDATATransform.swift
//  XMLMapper
//
//  Created by Giorgos Charitakis on 10/07/2018.
//

import Foundation

open class XMLCDATATransform: XMLTransformType {
    public typealias Object = String
    public typealias XML = [Data]
    
    private let encoding: String.Encoding
    private let separator: String
    
    public init(encoding: String.Encoding = .utf8, separator: String = "\n") {
        self.encoding = encoding
        self.separator = separator
    }
    
    public func transformFromXML(_ value: Any?) -> Object? {
        return (value as? [Data])?.compactMap { String(data: $0, encoding: encoding) }.joined(separator: separator)
    }
    
    public func transformToXML(_ value: String?) -> XML? {
        guard let cdata = value?.data(using: encoding) else {
            return nil
        }
        return [cdata]
    }
}
