//
//  XMLDateFormatterTransform.swift
//  XMLMapper
//
//  Created by Giorgos Charitakis on 15/09/2017.
//
//

import Foundation

open class XMLDateFormatterTransform: XMLTransformType {
    public typealias Object = Date
    public typealias XML = String
    
    public let dateFormatter: DateFormatter
    
    public init(dateFormatter: DateFormatter) {
        self.dateFormatter = dateFormatter
    }
    
    open func transformFromXML(_ value: Any?) -> Date? {
        if let dateString = value as? String {
            return dateFormatter.date(from: dateString)
        }
        return nil
    }
    
    open func transformToXML(_ value: Date?) -> String? {
        if let date = value {
            return dateFormatter.string(from: date)
        }
        return nil
    }
}
