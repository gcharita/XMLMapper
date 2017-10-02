//
//  XMLSerialization.swift
//  XMLMapper
//
//  Created by Giorgos Charitakis on 30/09/2017.
//

import Foundation
import XMLDictionary

public class XMLSerialization {
    private enum XMLSerializationError: String, Error {
        case invalidXMLDocument = "Invalid XML document"
        case invalidFoundationObject = "Invalid Foundation object"
        case invalidData = "Invalid data"
        
        var localizedDescription: String {
            return rawValue
        }
    }
    
    /* Returns YES if the given object can be converted to XML data, NO otherwise. The object must have the following properties:
     - Top level object is an NSArray or NSDictionary
     - All objects are NSString, NSNumber, NSArray, NSDictionary, or NSNull
     - All dictionary keys are NSStrings
     - NSNumbers are not NaN or infinity
     Other rules may apply. Calling this method or attempting a conversion are the definitive ways to tell if a given object can be converted to XML data.
     */
    open class func isValidXMLObject(_ obj: Any) -> Bool {
        do {
            _ = try data(withXMLObject: obj)
            return true
        } catch {
            return false
        }
    }
    
    open class func xmlObject(withString xmlString: String) throws -> Any {
        prepareXMLDictionaryParser()
        guard let xmlObject = XMLDictionaryParser.sharedInstance().dictionary(with: xmlString) else {
            throw XMLSerializationError.invalidXMLDocument
        }
        return xmlObject
    }
    
    /* Create a Foundation object from XML data. If an error occurs during the parse, then an exception will be thrown.
     The data must be in one of the 5 supported encodings listed in the XML specification: UTF-8, UTF-16LE, UTF-16BE, UTF-32LE, UTF-32BE. The data may or may not have a BOM. The most efficient encoding to use for parsing is UTF-8, so if you have a choice in encoding the data passed to this method, use UTF-8.
     */
    open class func xmlObject(with data: Data) throws -> Any {
        prepareXMLDictionaryParser()
        guard let xmlObject =  XMLDictionaryParser.sharedInstance().dictionary(with: data) else {
            throw XMLSerializationError.invalidData
        }
        return xmlObject
    }
    
    /* Generate XML data from a Foundation object. If an error occurs, then an exception will be thrown. The resulting data is a encoded in UTF-8.
     */
    open class func data(withXMLObject obj: Any, appendingXMLDeclaration: Bool = false) throws -> Data {
        prepareXMLDictionaryParser()
        guard var xmlString = (obj as? XMLRepresentable)?.xmlString else {
            throw XMLSerializationError.invalidFoundationObject
        }
        if appendingXMLDeclaration {
            xmlString = "<?xml version=\"1.0\" encoding=\"utf-8\"?>\(xmlString)"
        }
        guard let data = xmlString.data(using: .utf8) else {
            throw XMLSerializationError.invalidFoundationObject
        }
        return data
    }
    
    // Make sure that the XMLDictionaryParser instance has always the right configuration
    private static func prepareXMLDictionaryParser() {
        XMLDictionaryParser.sharedInstance().collapseTextNodes = true
        XMLDictionaryParser.sharedInstance().stripEmptyNodes = true
        XMLDictionaryParser.sharedInstance().trimWhiteSpace = true
        XMLDictionaryParser.sharedInstance().alwaysUseArrays = false
        XMLDictionaryParser.sharedInstance().preserveComments = false
        XMLDictionaryParser.sharedInstance().wrapRootNode = false
        XMLDictionaryParser.sharedInstance().attributesMode = .prefixed
        XMLDictionaryParser.sharedInstance().nodeNameMode = .always
    }
}
