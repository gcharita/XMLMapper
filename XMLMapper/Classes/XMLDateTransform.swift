//
//  XMLDateTransform.swift
//  XMLMapper
//
//  Created by Giorgos Charitakis on 15/09/2017.
//
//

import Foundation

open class XMLDateTransform: XMLTransformType {
    public typealias Object = Date
    public typealias XML = Double
    
    public init() {}
    
    open func transformFromXML(_ value: Any?) -> Date? {
        if let timeInt = value as? Double {
            return Date(timeIntervalSince1970: TimeInterval(timeInt))
        }
        
        if let timeStr = value as? String {
            return Date(timeIntervalSince1970: TimeInterval(atof(timeStr)))
        }
        
        return nil
    }
    
    open func transformToXML(_ value: Date?) -> Double? {
        if let date = value {
            return Double(date.timeIntervalSince1970)
        }
        return nil
    }
}
