//
//  XMLDictionaryParser.swift
//  XMLMapper
//
//  Created by Giorgos Charitakis on 07/10/2017.
//

import Foundation

enum XMLDictionaryAttributesMode {
    case prefixed
    case dictionary
    case unprefixed
    case discard
}

enum XMLDictionaryNodeNameMode {
    case rootOnly
    case always
    case never
}

let XMLDictionaryAttributesKey = "__attributes"
let XMLDictionaryCommentsKey = "__comments"
let XMLDictionaryTextKey = "__text"
let XMLDictionaryNodeNameKey = "__name"
let XMLDictionaryAttributePrefix = "_"

class XMLDictionaryParser: NSObject, NSCopying, XMLParserDelegate {
    
    // MARK: - Properties
    
    static let shared = XMLDictionaryParser()
    
    var collapseTextNodes: Bool
    var stripEmptyNodes: Bool
    var trimWhiteSpace: Bool
    var alwaysUseArrays: Bool
    var preserveComments: Bool
    var wrapRootNode: Bool
    var attributesMode: XMLDictionaryAttributesMode = .prefixed
    var nodeNameMode: XMLDictionaryNodeNameMode = .rootOnly
    
    var root: [String: Any]?
    var stack: [[String: Any]]?
    var text: String?
    
    internal required override init() {
        collapseTextNodes = true
        stripEmptyNodes = true
        trimWhiteSpace = true
        alwaysUseArrays = false
        preserveComments = false
        wrapRootNode = false
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        let copy = type(of: self).init()
        copy.collapseTextNodes = collapseTextNodes
        copy.stripEmptyNodes = stripEmptyNodes
        copy.trimWhiteSpace = trimWhiteSpace
        copy.alwaysUseArrays = alwaysUseArrays
        copy.preserveComments = preserveComments
        copy.attributesMode = attributesMode
        copy.nodeNameMode = nodeNameMode
        copy.wrapRootNode = wrapRootNode
        return copy
    }
    
    func dictionary(with parser: XMLParser) -> [String: Any]? {
        parser.delegate = self
        parser.parse()
        let result = root
        root = nil
        stack = nil
        text = nil
        return result
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
    
    class func xmlString(forNode node: Any, withNodeName nodeName: String) -> String? {
        if let nodeArray = node as? [Any] {
            let nodes = nodeArray.flatMap({ xmlString(forNode: $0, withNodeName: nodeName) })
            return nodes.joined(separator: "\n")
        } else if let nodeDictionary = node as? [String: Any] {
            var attributeString = ""
            if let attributes = nodeDictionary.attributes {
                attributeString = attributes.map({ String(format: " %@=\"%@\"", $0.key, $0.value) }).joined()
            }
            let innerXML = nodeDictionary.innerXML
            if !innerXML.isEmpty {
                return String(format: "<%1$@%2$@>%3$@</%1$@>", nodeName, attributeString, innerXML)
            } else {
                return String(format: "<%1$@>%2$@</%1$@>", nodeName, attributeString)
            }
        } else if let nodeString = node as? String {
            return String(format: "<%1$@>%2$@</%1$@>", nodeName, nodeString.xmlEncodedString)
        }
        return nil
    }
    
    func endText() {
        if trimWhiteSpace {
            text = text?.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        if let text = text, !text.isEmpty {
            var top = stack?.last
            let existing = top?[XMLDictionaryTextKey]
            if var existingArray = existing as? [Any] {
                existingArray.append(text)
            } else if let existing = existing {
                top?[XMLDictionaryTextKey] = [existing, text]
            } else {
                top?[XMLDictionaryTextKey] = text
            }
        }
        text = nil
    }
    
    func addText(_ additionalText: String) {
        if case nil = text?.append(additionalText) {
            text = additionalText
        }
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        endText()
        
        var node: [String: Any] = [:]
        switch nodeNameMode {
        case .rootOnly:
            if root == nil {
                node[XMLDictionaryNodeNameKey] = elementName
            }
        case .always:
            node[XMLDictionaryNodeNameKey] = elementName
        case .never:
            break
        }
        
        if !attributeDict.isEmpty {
            switch attributesMode {
            case .prefixed:
                for (key, value) in attributeDict {
                    node["\(XMLDictionaryAttributePrefix)\(key)"] = value
                }
            case .dictionary:
                node[XMLDictionaryAttributesKey] = attributeDict
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
            var top = stack?.last
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
    
    func name(forNode node: [String: Any]?, inDictionary dict: [String: Any]?) -> String? {
        if let nodeName = node?.nodeName {
            return nodeName
        } else if let node = node {
            return dict?.keys.filter({ (key: String) -> Bool in
                let object = dict?[key]
                if let objectDictionary = object as? [String: Any], objectDictionary == node {
                    return true
                } else if let objectArray = object as? [[String: Any]] {
                    return objectArray.contains(where: { $0 == node })
                }
                return false
            }).first
        }
        return nil
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        endText()
        
        var top = stack?.removeLast()
        
        if top?.attributes == nil && top?.childNodes == nil && top?.comments == nil {
            var newTop = stack?.last
            if let nodeName = name(forNode: top, inDictionary: newTop) {
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
                            newTop?.removeValue(forKey: nodeName)
                        }
                    } else if !collapseTextNodes {
                        top?[XMLDictionaryTextKey] = ""
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
            var top = stack?.last
            var comments = top?[XMLDictionaryCommentsKey] as? [String]
            if comments == nil {
                comments = [comment]
                top?[XMLDictionaryCommentsKey] = comments
            } else {
                comments?.append(comment)
            }
        }
    }
}

func == <K, V>(left: [K: V], right: [K: V]) -> Bool {
    return NSDictionary(dictionary: left).isEqual(to: right)
}

extension Dictionary {
    static func with(parser: XMLParser) -> [String: Any]? {
        return XMLDictionaryParser.shared.dictionary(with: parser)
    }
    
    static func with(data: Data) -> [String: Any]? {
        return XMLDictionaryParser.shared.dictionary(withData: data)
    }
    
    static func with(string: String) -> [String: Any]? {
        return XMLDictionaryParser.shared.dictionary(withString: string)
    }
    
    static func with(filePath: String) -> [String: Any]? {
        return XMLDictionaryParser.shared.dictionary(withFile: filePath)
    }
    
    var attributes: [String: String]? {
        let dictionary = self as? [String: Any]
        if let attributes = dictionary?[XMLDictionaryAttributesKey] {
            return attributes as? [String: String]
        } else {
            var filteredDict = dictionary
            let filteredKeys = [XMLDictionaryCommentsKey, XMLDictionaryTextKey, XMLDictionaryNodeNameKey]
            filteredKeys.forEach({ filteredDict?.removeValue(forKey: $0) })
            filteredDict?.keys.forEach({ (key: String) in
                filteredDict?.removeValue(forKey: key)
                if key.hasPrefix(XMLDictionaryAttributePrefix) {
                    filteredDict?[key.substring(from: XMLDictionaryAttributePrefix.endIndex)] = dictionary?[key]
                }
            })
            return filteredDict as? [String: String]
        }
    }
    
    var childNodes: [String: Any]? {
        var filteredDict = self as? [String: Any]
        let filteredKeys = [XMLDictionaryAttributesKey, XMLDictionaryCommentsKey, XMLDictionaryTextKey, XMLDictionaryNodeNameKey]
        filteredKeys.forEach({ filteredDict?.removeValue(forKey: $0) })
        filteredDict?.keys.forEach({ (key: String) in
            if key.hasPrefix(XMLDictionaryAttributePrefix) {
                filteredDict?.removeValue(forKey: key)
            }
        })
        return filteredDict
    }
    
    var comments: [String]? {
        return (self as [AnyHashable: Any])[XMLDictionaryCommentsKey] as? [String]
    }
    
    var nodeName: String? {
        return (self as [AnyHashable: Any])[XMLDictionaryNodeNameKey] as? String
    }
    
    var innerText: String? {
        let text = (self as [AnyHashable: Any])[XMLDictionaryTextKey]
        if let stringArray = text as? [String] {
            return stringArray.joined(separator: "\n")
        }
        return text as? String
    }
    
    var innerXML: String {
        var nodes: [String] = []
        
        comments?.forEach({ (comment: String) in
            nodes.append(String(format: "<!--%@-->", comment.xmlEncodedString))
        })
        
        childNodes?.forEach({ (childNode:(key: String, value: Any)) in
            if let xmlStringNode = XMLDictionaryParser.xmlString(forNode: childNode.value, withNodeName: childNode.key) {
                nodes.append(xmlStringNode)
            }
        })
        
        if let text = innerText {
            nodes.append(text)
        }
        
        return nodes.joined(separator: "\n")
    }
    
    var xmlString: String {
        if self.count == 1 && nodeName == nil {
            return innerXML
        } else {
            return XMLDictionaryParser.xmlString(forNode: self, withNodeName: nodeName ?? "root") ?? ""
        }
    }
}

extension String {
    var xmlEncodedString: String {
        return self.replacingOccurrences(of: "&", with: "&amp;")
            .replacingOccurrences(of: "<", with: "&lt;")
            .replacingOccurrences(of: ">", with: "&gt;")
            .replacingOccurrences(of: "\"", with: "&quot;")
            .replacingOccurrences(of: "\'", with: "&apos;")
    }
}
