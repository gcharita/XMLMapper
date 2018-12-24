//
//  XMLSerialization+ReadingOptions.swift
//  XMLMapper
//
//  Created by Giorgos Charitakis on 21/10/2017.
//

import Foundation

extension XMLSerialization {
    public struct ReadingOptions: OptionSet {
        public let rawValue: Int
        
        public init(rawValue: Int) {
            self.rawValue = rawValue
        }
        
        public static let collapseTextNodes = ReadingOptions(rawValue: 1 << 0)
        public static let stripEmptyNodes = ReadingOptions(rawValue: 1 << 1)
        public static let trimWhiteSpace = ReadingOptions(rawValue: 1 << 2)
        public static let alwaysUseArrays = ReadingOptions(rawValue: 1 << 3)
        public static let preserveComments = ReadingOptions(rawValue: 1 << 4)
        public static let wrapRootNode = ReadingOptions(rawValue: 1 << 5)
        public static let keepNodesOrder = ReadingOptions(rawValue: 1 << 6)
        
        public static let prefixedAttributes = ReadingOptions(rawValue: 1 << 7)
        public static let unprefixedAttributes = ReadingOptions(rawValue: 1 << 8)
        public static let dictionaryAttributes = ReadingOptions(rawValue: 1 << 9)
        public static let discardAttributes = ReadingOptions(rawValue: 1 << 10)
        
        public static let rootOnlyNodeName = ReadingOptions(rawValue: 1 << 11)
        public static let alwaysNodeName = ReadingOptions(rawValue: 1 << 12)
        public static let neverNodeName = ReadingOptions(rawValue: 1 << 13)
        
        public static let `default`: ReadingOptions = [
            .collapseTextNodes,
            .trimWhiteSpace,
            .keepNodesOrder,
            .prefixedAttributes,
            .alwaysNodeName,
        ]
    }
}
