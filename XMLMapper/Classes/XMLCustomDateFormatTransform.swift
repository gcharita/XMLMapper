//
//  XMLCustomDateFormatTransform.swift
//  XMLMapper
//
//  Created by Giorgos Charitakis on 15/09/2017.
//
//

import Foundation

open class XMLCustomDateFormatTransform: XMLDateFormatterTransform {
    
    public init(formatString: String, withLocaleIdentifier localeIdentifier: String = "en_US_POSIX") {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: localeIdentifier)
        formatter.dateFormat = formatString
        
        super.init(dateFormatter: formatter)
    }
}
