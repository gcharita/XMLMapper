//
//  XMLDictionaryParser.swift
//  XMLMapper
//
//  Created by Giorgos Charitakis on 07/10/2017.
//

import Foundation

enum XMLObjectParserAttributesMode {
    case prefixed
    case dictionary
    case unprefixed
    case discard
}

enum XMLObjectParserNodeNameMode {
    case rootOnly
    case always
    case never
}

class XMLObjectParser: NSObject {
    
    // MARK: - Properties
    
    private var collapseTextNodes: Bool
    private var stripEmptyNodes: Bool
    private var trimWhiteSpace: Bool
    private var alwaysUseArrays: Bool
    private var preserveComments: Bool
    private var wrapRootNode: Bool
    private var attributesMode: XMLObjectParserAttributesMode = .prefixed
    private var nodeNameMode: XMLObjectParserNodeNameMode = .always
    
    private var root: NSMutableDictionary?
    private var stack: [NSMutableDictionary]?
    private var text: String?
    
    // MARK: - Initialazer
    
    internal required override init() {
        collapseTextNodes = true
        stripEmptyNodes = true
        trimWhiteSpace = true
        alwaysUseArrays = false
        preserveComments = false
        wrapRootNode = false
    }
    
    // MARK: - Basic interface function
    
    class func dictionary(with parser: XMLParser, options: XMLSerialization.ReadingOptions) -> [String: Any]? {
        let xmlObjectParser = XMLObjectParser()
        parser.delegate = xmlObjectParser
        xmlObjectParser.applyOptions(options)
        parser.parse()
        let result = xmlObjectParser.root
        xmlObjectParser.clearProperties()
        return result as? [String: Any]
    }
    
    // MARK: - Util functions
    
    func applyOptions(_ options: XMLSerialization.ReadingOptions = .default) {
        collapseTextNodes = options.contains(.collapseTextNodes)
        stripEmptyNodes = options.contains(.stripEmptyNodes)
        trimWhiteSpace = options.contains(.trimWhiteSpace)
        alwaysUseArrays = options.contains(.alwaysUseArrays)
        preserveComments = options.contains(.preserveComments)
        wrapRootNode = options.contains(.wrapRootNode)

        if options.contains(.prefixedAttributes) {
            attributesMode = .prefixed
        } else if options.contains(.unprefixedAttributes) {
            attributesMode = .unprefixed
        } else if options.contains(.dictionaryAttributes) {
            attributesMode = .dictionary
        } else if options.contains(.discardAttributes) {
            attributesMode = .discard
        }

        if options.contains(.alwaysNodeName) {
            nodeNameMode = .always
        } else if options.contains(.rootOnlyNodeName) {
            nodeNameMode = .rootOnly
        } else if options.contains(.neverNodeName) {
            nodeNameMode = .never
        }
    }
    
    func clearProperties() {
        root = nil
        stack = nil
        text = nil
        applyOptions()
    }
    
    func endText() {
        if trimWhiteSpace {
            text = text?.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        if let text = text, !text.isEmpty {
            let top = stack?.last
            let existing = top?[XMLParserConstant.Key.text]
            if let existingArray = existing as? NSMutableArray {
                existingArray.add(text)
            } else if let existing = existing {
                top?[XMLParserConstant.Key.text] = NSMutableArray(array: [existing, text])
            } else {
                top?[XMLParserConstant.Key.text] = text
            }
        }
        text = nil
    }
    
    func addText(_ additionalText: String) {
        if case nil = text?.append(additionalText) {
            text = additionalText
        }
    }
}

// MARK: - XMLParserDelegate

extension XMLObjectParser: XMLParserDelegate {
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        endText()
        
        let node: NSMutableDictionary = [:]
        switch nodeNameMode {
        case .rootOnly:
            if root == nil {
                node[XMLParserConstant.Key.nodeName] = elementName
            }
        case .always:
            node[XMLParserConstant.Key.nodeName] = elementName
        case .never:
            break
        }
        
        if !attributeDict.isEmpty {
            switch attributesMode {
            case .prefixed:
                for (key, value) in attributeDict {
                    node["\(XMLParserConstant.attributePrefix)\(key)"] = value
                }
            case .dictionary:
                node[XMLParserConstant.Key.attributes] = attributeDict
            case .unprefixed:
                for (key, value) in attributeDict {
                    node[key] = value
                }
            case .discard:
                break
            }
        }
        
        if root == nil {
            root = node
            stack = [node]
            if wrapRootNode {
                root = [elementName: root!]
                stack?.insert(root!, at: 0)
            }
        } else {
            let top = stack?.last
            let existing = top?[elementName]
            if let existingArray = existing as? NSMutableArray {
                existingArray.add(node)
            } else if let existing = existing {
                top?[elementName] = NSMutableArray(array: [existing, node])
            } else if alwaysUseArrays {
                top?[elementName] = NSMutableArray(object: node)
            } else {
                top?[elementName] = node
            }
            stack?.append(node)
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        endText()
        
        let top = stack?.removeLast()
        
        if top?.attributes == nil && top?.childNodes == nil && top?.comments == nil {
            let newTop = stack?.last
            if let nodeName = XMLParserHelper.name(forNode: top as? [String: Any], inDictionary: newTop as? [String: Any]) {
                let parentNode = newTop?[nodeName]
                let innerText = top?.innerText
                if let innerText = innerText, collapseTextNodes {
                    if let parentNodeArray = parentNode as? NSMutableArray {
                        parentNodeArray[parentNodeArray.count - 1] = innerText
                    } else {
                        newTop?[nodeName] = innerText
                    }
                } else if innerText == nil {
                    if stripEmptyNodes {
                        if let parentNodeArray = parentNode as? NSMutableArray {
                            parentNodeArray.removeLastObject()
                        } else {
                            newTop?.removeObject(forKey: nodeName)
                        }
                    } else if !collapseTextNodes {
                        top?[XMLParserConstant.Key.text] = ""
                    }
                }
            }
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        addText(string)
    }
    
    func parser(_ parser: XMLParser, foundCDATA CDATABlock: Data) {
        guard let string = String(data: CDATABlock, encoding: .utf8) else {
            return
        }
        addText(string)
    }
    
    func parser(_ parser: XMLParser, foundComment comment: String) {
        if preserveComments {
            let top = stack?.last
            var comments = top?[XMLParserConstant.Key.comments] as? NSMutableArray
            if comments == nil {
                comments = NSMutableArray(object: comment)
                top?[XMLParserConstant.Key.comments] = comments
            } else {
                comments?.add(comment)
            }
        }
    }
}
