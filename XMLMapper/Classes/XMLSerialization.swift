//
//  XMLSerialization.swift
//  XMLMapper
//
//  Created by Giorgos Charitakis on 30/09/2017.
//

import Foundation

/// An object that converts between XML and the equivalent Foundation objects.
public class XMLSerialization {
    
    /// Returns a Boolean value that indicates whether a given object can be converted to XML data.
    ///
    /// Returns YES if the given object can be converted to XML data, NO otherwise. The object must have the following properties:
    ///     - Top level object is an NSArray or NSDictionary
    ///     - All objects are NSString, NSNumber, NSArray, NSDictionary, or NSNull
    ///     - All dictionary keys are NSStrings
    ///     - NSNumbers are not NaN or infinity
    /// Other rules may apply. Calling this method or attempting a conversion are the definitive ways to tell if a given object can be converted to XML data.
    ///
    /// - parameter obj: The object to test.
    ///
    /// - returns: true if obj can be converted to XML data, otherwise false.
    open class func isValidXMLObject(_ obj: Any) -> Bool {
        do {
            _ = try data(withXMLObject: obj)
            return true
        } catch {
            return false
        }
    }
    
    /// Returns a Foundation object from given XML string.
    ///
    /// Create a Foundation object from XML string. If an error occurs during the parse, then an exception will be thrown.
    ///
    /// - parameter xmlString: A string containing the XML.
    /// - parameter encoding: The string Encoding. Default value is UTF-8
    /// - parameter options: Options for reading the XML string and creating the Foundation objects.
    ///
    /// - throws: An `Error` if the parsing process encounters an error.
    ///
    /// - returns: A Foundation object from the XML string.
    open class func xmlObject(withString xmlString: String, using encoding: String.Encoding = .utf8, options: ReadingOptions = .default) throws -> Any {
        
        func data(fromString xmlString: String, using encoding: String.Encoding) throws -> Data {
            guard let xmlData = xmlString.data(using: encoding) else {
                throw XMLSerializationError.invalidXMLDocument
            }
            return xmlData
        }
        
        // Parsing xmlString as a Dictionary if XML declaration exists
        if xmlString.contains("<?xml") {
            let xmlData = try data(fromString: xmlString, using: encoding)
            guard let xmlObject = try XMLObjectParser.dictionary(with: xmlData, options: options) else {
                throw XMLSerializationError.invalidData
            }
            return xmlObject
        }
        
        // Wrapping the XML string with a node to cover cases that the return value should be [[String: Any]].
        // XMLParser does not parse XML data that have more than one root nodes.
        let wrapedElement = "wrapper"
        let wrapedXMLString = "<\(wrapedElement)>\(xmlString)</\(wrapedElement)>"
        
        let xmlData = try data(fromString: wrapedXMLString, using: encoding)
        guard let xmlObject = try XMLObjectParser.dictionary(with: xmlData, options: options)?.childNodes?.first?.value else {
            throw XMLSerializationError.invalidData
        }
        return xmlObject
    }
    
    /// Returns a Foundation object from given XML data.
    ///
    /// Create a Foundation object from XML data. If an error occurs during the parse, then an exception will be thrown.
    ///
    /// - parameter data: A data object containing XML data.
    /// - parameter encoding: The data Encoding. Default value is UTF-8
    /// - parameter options: Options for reading the XML data and creating the Foundation objects.
    ///
    /// - throws: An `Error` if the parsing process encounters an error.
    ///
    /// - returns: A Foundation object from the XML data in data.
    open class func xmlObject(with data: Data, encoding: String.Encoding = .utf8, options: ReadingOptions = .default) throws -> Any {
        guard let xmlString = String(data: data, encoding: encoding) else {
            throw XMLSerializationError.invalidData
        }
        return try xmlObject(withString: xmlString, options: options)
    }
    
    /// Returns XML data from a Foundation object.
    ///
    /// - parameter obj: The object from which to generate XML data. Must not be nil.
    /// - parameter addXMLDeclaration: Boolean value that indicates whether XML declaration will be added in returned data
    ///
    /// - throws: An `Error` if the parsing process encounters an error.
    ///
    /// - returns: XML data for obj. The resulting data is encoded in UTF-8.
    open class func data(withXMLObject obj: Any, addXMLDeclaration: Bool = false) throws -> Data {
        guard var xmlString = (obj as? XMLRepresentable)?.xmlString else {
            throw XMLSerializationError.invalidFoundationObject
        }
        if addXMLDeclaration {
            xmlString = "<?xml version=\"1.0\" encoding=\"utf-8\"?>\n\(xmlString)"
        }
        guard let data = xmlString.data(using: .utf8) else {
            throw XMLSerializationError.invalidFoundationObject
        }
        return data
    }
}