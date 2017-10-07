//
//  XMLCustomDateFormatTransform.swift
//  XMLMapper
//
//  Created by Giorgos Charitakis on 15/09/2017.
//
//

import Foundation

open class XMLCustomDateFormatTransform: XMLDateFormatterTransform {
    
    public init(formatString: String, with locale: Locale = Locale(identifier: "en_US_POSIX")) {
        let formatter = DateFormatter()
        formatter.locale = locale
        formatter.dateFormat = formatString
        
        super.init(dateFormatter: formatter)
    }
    
    public init(formatString: String, withLocaleIdentifier localeIdentifier: String = "en_US_POSIX") {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: localeIdentifier)
        formatter.dateFormat = formatString
        
        super.init(dateFormatter: formatter)
    }
}
