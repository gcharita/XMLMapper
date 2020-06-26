//
//  DataRequest+XMLMapper.swift
//  XMLMapper
//
//  Created by Giorgos Charitakis on 30/09/2017.
//

import Foundation
import Alamofire

extension DataRequest {
    enum ErrorCode: Int {
        case noData = 1
        case dataSerializationFailed = 2
    }
    
    internal static func newError(_ code: ErrorCode, failureReason: String) -> NSError {
        let errorDomain = "com.alamofirexmlmapper.error"
        
        let userInfo = [NSLocalizedFailureReasonErrorKey: failureReason]
        let returnError = NSError(domain: errorDomain, code: code.rawValue, userInfo: userInfo)
        
        return returnError
    }
    
    /// Utility function for extracting XML from response
    internal static func processResponse(
        request: URLRequest?,
        response: HTTPURLResponse?,
        data: Data?,
        keyPath: String?,
        encoding: String.Encoding?
    ) -> Any? {
        var XML: Any?
        do {
            let stringResponseSerializer = StringResponseSerializer(encoding: encoding)
            let xmlString = try stringResponseSerializer.serialize(request: request, response: response, data: data, error: nil)
            XML = try XMLSerialization.xmlObject(withString: xmlString, using: encoding ?? .utf8)
            if let keyPath = keyPath, keyPath.isEmpty == false {
                XML = (XML as AnyObject?)?.value(forKeyPath: keyPath)
            }
        } catch {
            print(error)
            XML = nil
        }
        
        return XML
    }
    
    /// XMLBaseMappable Object Serializer
    public static func XMLMapperSerializer<T: XMLBaseMappable>(
        _ keyPath: String?,
        mapToObject object: T? = nil,
        encoding: String.Encoding? = nil
    ) -> XMLMappableResponseSerializer<T> {
        return XMLMappableResponseSerializer<T>(keyPath, mapToObject: object) { request, response, data, error in
            let XMLObject = processResponse(request: request, response: response, data: data, keyPath: keyPath, encoding: encoding)
            
            if let object = object {
                _ = XMLMapper<T>().map(XMLObject: XMLObject, toObject: object)
                return object
            } else if let parsedObject = XMLMapper<T>().map(XMLObject: XMLObject) {
                return parsedObject
            }
            
            let failureReason = "XMLMapper failed to serialize response."
            throw AFError.responseSerializationFailed(reason: .decodingFailed(error: newError(.dataSerializationFailed, failureReason: failureReason)))
        }
    }
    
    /// Adds a handler to be called once the request has finished.
    ///
    /// - parameters:
    ///     - queue: The queue on which the completion handler is dispatched.
    ///     - keyPath: The key path where object mapping should be performed
    ///     - object: An object to perform the mapping on to
    ///     - completionHandler: A closure to be executed once the request has finished and the data has been mapped by XMLMapper.
    ///     - encoding: The string Encoding. Default value is UTF-8
    ///
    /// - returns: The request.
    @discardableResult
    public func responseXMLObject<T: XMLBaseMappable>(
        queue: DispatchQueue = .main,
        keyPath: String? = nil,
        mapToObject object: T? = nil,
        encoding: String.Encoding? = nil,
        completionHandler: @escaping (AFDataResponse<T>) -> Void
    ) -> Self {
        return response(
            queue: queue,
            responseSerializer: DataRequest.XMLMapperSerializer(keyPath, mapToObject: object, encoding: encoding),
            completionHandler: completionHandler
        )
    }
    
    /// XMLBaseMappable Array Serializer
    public static func XMLMapperArraySerializer<T: XMLBaseMappable>(
        _ keyPath: String?,
        encoding: String.Encoding? = nil
    ) -> XMLMappableArrayResponseSerializer<T> {
        return XMLMappableArrayResponseSerializer(keyPath) { request, response, data, error in
            let XMLObject = processResponse(request: request, response: response, data: data, keyPath: keyPath, encoding: encoding)
            
            if let parsedObject = XMLMapper<T>().mapArray(XMLObject: XMLObject) {
                return parsedObject
            }
            
            let failureReason = "XMLMapper failed to serialize response."
            throw AFError.responseSerializationFailed(reason: .decodingFailed(error: newError(.dataSerializationFailed, failureReason: failureReason)))
        }
    }
    
    /// Adds a handler to be called once the request has finished. T: XMLBaseMappable
    ///
    /// - parameters:
    ///     - queue: The queue on which the completion handler is dispatched.
    ///     - keyPath: The key path where object mapping should be performed
    ///     - completionHandler: A closure to be executed once the request has finished and the data has been mapped by XMLMapper.
    ///     - encoding: The string Encoding. Default value is UTF-8
    ///
    /// - returns: The request.
    @discardableResult
    public func responseXMLArray<T: XMLBaseMappable>(
        queue: DispatchQueue = .main,
        keyPath: String? = nil,
        encoding: String.Encoding? = nil,
        completionHandler: @escaping (AFDataResponse<[T]>) -> Void
    ) -> Self {
        return response(
            queue: queue,
            responseSerializer: DataRequest.XMLMapperArraySerializer(keyPath, encoding: encoding),
            completionHandler: completionHandler
        )
    }
}
