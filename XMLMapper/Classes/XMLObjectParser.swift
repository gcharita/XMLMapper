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

let XMLObjectParserAttributesKey = "__attributes"
let XMLObjectParserCommentsKey = "__comments"
let XMLObjectParserTextKey = "__text"
let XMLObjectParserNodeNameKey = "__name"
let XMLObjectParserAttributePrefix = "_"

class XMLObjectParser: NSObject {
    
    // MARK: - Properties
    
    static let shared = XMLObjectParser()
    
    var collapseTextNodes: Bool
    var stripEmptyNodes: Bool
    var trimWhiteSpace: Bool
    var alwaysUseArrays: Bool
    var preserveComments: Bool
    var wrapRootNode: Bool
    var attributesMode: XMLObjectParserAttributesMode = .prefixed
    var nodeNameMode: XMLObjectParserNodeNameMode = .always
    
    fileprivate var root: NSMutableDictionary?
    fileprivate var stack: [NSMutableDictionary]?
    fileprivate var text: String?
    
    // MARK: - Initialazer
    
    internal required override init() {
        collapseTextNodes = true
        stripEmptyNodes = true
        trimWhiteSpace = true
        alwaysUseArrays = false
        preserveComments = false
        wrapRootNode = false
    }
    
    // MARK: - Basic interface functions
    
    func dictionary(with parser: XMLParser) -> [String: Any]? {
        parser.delegate = self
        parser.parse()
        let result = root
        root = nil
        stack = nil
        text = nil
        return result as? [String: Any]
    }
    
    func dictionary(withData data: Data) -> [String: Any]? {
        let parser = XMLParser(data: data)
        return dictionary(with: parser)
    }
    
    func dictionary(withString string: String) -> [String: Any]? {
        guard let data = string.data(using: .utf8) else {
            return nil
        }
        return dictionary(withData: data)
    }
    
    func dictionary(withFile path: String) -> [String: Any]? {
        do {
            let string = try String(contentsOfFile: path)
            return dictionary(withString: string)
        } catch {
            return nil
        }
    }
    
    // MARK: - Util functions
    
    func endText() {
        if trimWhiteSpace {
            text = text?.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        if let text = text, !text.isEmpty {
            let top = stack?.last
            let existing = top?[XMLObjectParserTextKey]
            if var existingArray = existing as? [Any] {
                existingArray.append(text)
            } else if let existing = existing {
                top?[XMLObjectParserTextKey] = [existing, text]
            } else {
                top?[XMLObjectParserTextKey] = text
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
                node[XMLObjectParserNodeNameKey] = elementName
            }
        case .always:
            node[XMLObjectParserNodeNameKey] = elementName
        case .never:
            break
        }
        
        if !attributeDict.isEmpty {
            switch attributesMode {
            case .prefixed:
                for (key, value) in attributeDict {
                    node["\(XMLObjectParserAttributePrefix)\(key)"] = value
                }
            case .dictionary:
                node[XMLObjectParserAttributesKey] = attributeDict
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
            if var existingArray = existing as? [Any] {
                existingArray.append(node)
            } else if let existing = existing {
                top?[elementName] = [existing, node]
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
                    if var parentNodeArray = parentNode as? [Any] {
                        parentNodeArray[parentNodeArray.count - 1] = innerText
                    } else {
                        newTop?[nodeName] = innerText
                    }
                } else if innerText == nil {
                    if stripEmptyNodes {
                        if var parentNodeArray = parentNode as? [Any] {
                            parentNodeArray.removeLast()
                        } else {
                            newTop?.removeObject(forKey:
                                nodeName)
                        }
                    } else if !collapseTextNodes {
                        top?[XMLObjectParserTextKey] = ""
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
            var comments = top?[XMLObjectParserCommentsKey] as? [String]
            if comments == nil {
                comments = [comment]
                top?[XMLObjectParserCommentsKey] = comments
            } else {
                comments?.append(comment)
            }
        }
    }
}
