//
//  XMLEncoding.swift
//  Pods
//
//  Created by Giorgos Charitakis on 30/09/2017.
//

import Foundation
import Alamofire

/// Uses `XMLSerialization` to create a XML representation of the parameters object, which is set as the body of the
/// request. The `Content-Type` HTTP header field of an encoded request is set to `text/xml`.
public struct XMLEncoding: ParameterEncoding {
    
    // MARK: Properties
    
    /// Returns a `XMLEncoding` instance for a simple XML body
    public static var `default`: XMLEncoding { return XMLEncoding() }
    
    private var soapAction: String?
    
    // MARK: Initialization
    
    /// Creates a `XMLEncoding` instance
    private init() { }
    private init(soapAction: String) {
        self.soapAction = soapAction
    }
    
    /// Returns a `XMLEncoding` instance for a SOAP body
    public static func soap(withAction soapAction: String) -> XMLEncoding {
        return XMLEncoding(soapAction: soapAction)
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
        
        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue("text/xml; charset=\"utf-8\"", forHTTPHeaderField: "Content-Type")
        }
        
        let data = try XMLSerialization.data(withXMLObject: parameters)
        if let soapAction = soapAction {
            urlRequest.setValue(soapAction, forHTTPHeaderField: "SOAPACTION")
            urlRequest.setValue("\(data.count)", forHTTPHeaderField: "Content-Length")
        }
        
        urlRequest.httpBody = data
        
        return urlRequest
    }
}
