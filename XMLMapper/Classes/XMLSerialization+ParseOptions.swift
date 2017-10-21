//
//  XMLSerialization+ParseOptions.swift
//  XMLMapper
//
//  Created by Giorgos Charitakis on 21/10/2017.
//

import Foundation

extension XMLSerialization {
    public struct ParseOptions: OptionSet {
        public let rawValue: Int
        
        public init(rawValue: Int) {
            self.rawValue = rawValue
        }
        
        public static let collapseTextNodes = ParseOptions(rawValue: 1 << 0)
        public static let stripEmptyNodes = ParseOptions(rawValue: 1 << 1)
        public static let trimWhiteSpace = ParseOptions(rawValue: 1 << 2)
        public static let alwaysUseArrays = ParseOptions(rawValue: 1 << 3)
        public static let preserveComments = ParseOptions(rawValue: 1 << 4)
        public static let wrapRootNode = ParseOptions(rawValue: 1 << 5)
        
        public static let prefixedAttributes = ParseOptions(rawValue: 1 << 6)
        public static let unprefixedAttributes = ParseOptions(rawValue: 1 << 7)
        public static let dictionaryAttributes = ParseOptions(rawValue: 1 << 8)
        public static let discardAttributes = ParseOptions(rawValue: 1 << 9)
        
        public static let rootOnlyNodeName = ParseOptions(rawValue: 1 << 10)
        public static let alwaysNodeName = ParseOptions(rawValue: 1 << 11)
        public static let neverNodeName = ParseOptions(rawValue: 1 << 12)
        
        public static let `default`: ParseOptions = [
            .collapseTextNodes,
            .stripEmptyNodes,
            .trimWhiteSpace,
            .prefixedAttributes,
            .alwaysNodeName
        ]
        
        func applyToParser() {
            XMLObjectParser.shared.collapseTextNodes = contains(.collapseTextNodes)
            XMLObjectParser.shared.stripEmptyNodes = contains(.stripEmptyNodes)
            XMLObjectParser.shared.trimWhiteSpace = contains(.trimWhiteSpace)
            XMLObjectParser.shared.alwaysUseArrays = contains(.alwaysUseArrays)
            XMLObjectParser.shared.preserveComments = contains(.preserveComments)
            XMLObjectParser.shared.wrapRootNode = contains(.wrapRootNode)
            
            if contains(.prefixedAttributes) {
                XMLObjectParser.shared.attributesMode = .prefixed
            } else if contains(.unprefixedAttributes) {
                XMLObjectParser.shared.attributesMode = .unprefixed
            } else if contains(.dictionaryAttributes) {
                XMLObjectParser.shared.attributesMode = .dictionary
            } else if contains(.discardAttributes) {
                XMLObjectParser.shared.attributesMode = .discard
            }
            
            if contains(.alwaysNodeName) {
                XMLObjectParser.shared.nodeNameMode = .always
            } else if contains(.rootOnlyNodeName) {
                XMLObjectParser.shared.nodeNameMode = .rootOnly
            } else if contains(.neverNodeName) {
                XMLObjectParser.shared.nodeNameMode = .never
            }
        }
    }
}
