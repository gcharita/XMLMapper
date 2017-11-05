//
//  XMLSerialization.swift
//  XMLMapper
//
//  Created by Giorgos Charitakis on 30/09/2017.
//

import Foundation

public class XMLSerialization {
    
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
    
    open class func xmlObject(with parser: XMLParser, options: ReadingOptions = .default) throws -> Any {
        guard let xmlObject = XMLObjectParser.dictionary(with: parser, options: options) else {
            throw XMLSerializationError.invalidData
        }
        return xmlObject
    }
    
    open class func xmlObject(withString xmlString: String, using encoding: String.Encoding = .utf8, options: ReadingOptions = .default) throws -> Any {
        guard let xmlData = xmlString.data(using: encoding) else {
            throw XMLSerializationError.invalidXMLDocument
        }
        return try xmlObject(with: xmlData, options: options)
    }
    
    /* Create a Foundation object from XML data. If an error occurs during the parse, then an exception will be thrown.
     The data must be in one of the 5 supported encodings listed in the XML specification: UTF-8, UTF-16LE, UTF-16BE, UTF-32LE, UTF-32BE. The data may or may not have a BOM. The most efficient encoding to use for parsing is UTF-8, so if you have a choice in encoding the data passed to this method, use UTF-8.
     */
    open class func xmlObject(with data: Data, options: ReadingOptions = .default) throws -> Any {
        return try xmlObject(with: XMLParser(data: data), options: options)
    }
    
    /* Generate XML data from a Foundation object. If an error occurs, then an exception will be thrown. The resulting data is a encoded in UTF-8.
     */
    open class func data(withXMLObject obj: Any, appendingXMLDeclaration: Bool = false, options: ReadingOptions = .default) throws -> Data {
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
}
