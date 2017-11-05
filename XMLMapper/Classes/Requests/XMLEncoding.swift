//
//  XMLEncoding.swift
//  XMLMapper
//
//  Created by Giorgos Charitakis on 30/09/2017.
//

import Foundation
import Alamofire

/// Uses `XMLSerialization` to create a XML representation of the parameters object, which is set as the body of the
/// request. The `Content-Type` HTTP header field of an encoded request is set to `text/xml`.
public struct XMLEncoding: ParameterEncoding {
    
    // MARK: Properties
    
    /// Returns a `XMLEncoding` instance for a simple XML request body
    public static var `default`: XMLEncoding { return XMLEncoding() }
    
    private var soapAction: String?
    private var soapVersion: SOAPVersion?
    
    // MARK: Initialization
    
    /// Creates a `XMLEncoding` instance
    public init(withAction soapAction: String? = nil, soapVersion: SOAPVersion? = nil) {
        self.soapAction = soapAction
        self.soapVersion = soapVersion
    }
    
    /// Returns a `XMLEncoding` instance for a SOAP request body
    public static func soap(withAction soapAction: String?, soapVersion: SOAPVersion = .version1point1) -> XMLEncoding {
        return XMLEncoding(withAction: soapAction, soapVersion: soapVersion)
    }
    
    // MARK: Encoding
    
    /// Creates a URL request by encoding parameters and applying them onto an existing request.
    ///
    /// - parameter urlRequest: The request to have parameters applied.
    /// - parameter parameters: The parameters to apply.
    ///
    /// - throws: An `Error` if the encoding process encounters an error.
    ///
    /// - returns: The encoded request.
    public func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var urlRequest = try urlRequest.asURLRequest()
        
        guard let parameters = parameters else { return urlRequest }
        
        let data = try XMLSerialization.data(withXMLObject: parameters, addXMLDeclaration: true)
        
        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            switch soapVersion {
            case .none:
                urlRequest.setValue("text/xml; charset=\"utf-8\"", forHTTPHeaderField: "Content-Type")
            case .some(let soapVersion):
                var contentType = soapVersion.contentType
                if let soapAction = soapAction, soapVersion == .version1point2 {
                    contentType += ";action=\"\(soapAction)\""
                }
                urlRequest.setValue(contentType, forHTTPHeaderField: "Content-Type")
            }
        }
        
        if let soapAction = soapAction, urlRequest.value(forHTTPHeaderField: "SOAPAction") == nil, soapVersion == .version1point1 {
            urlRequest.setValue(soapAction, forHTTPHeaderField: "SOAPAction")
        }
        
        if urlRequest.value(forHTTPHeaderField: "Content-Length") == nil, soapVersion != nil {
            urlRequest.setValue("\(data.count)", forHTTPHeaderField: "Content-Length")
        }
        
        urlRequest.httpBody = data
        
        return urlRequest
    }
}
