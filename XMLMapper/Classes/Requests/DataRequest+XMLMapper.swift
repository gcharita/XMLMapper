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
    
    internal func newError(_ code: ErrorCode, failureReason: String = "XMLMapper failed to serialize response.") -> NSError {
        let errorDomain = "com.alamofirexmlmapper.error"
        
        let userInfo = [NSLocalizedFailureReasonErrorKey: failureReason]
        let returnError = NSError(domain: errorDomain, code: code.rawValue, userInfo: userInfo)
        
        return returnError
    }
    
    /// Utility function for extracting XML from response
    internal func processResponse(
        request: URLRequest?,
        response: HTTPURLResponse?,
        data: Data?,
        keyPath: String?,
        encoding: String.Encoding?,
        options: XMLSerialization.ReadingOptions
    ) -> Any? {
        var XML: Any?
        do {
            let stringResponseSerializer = StringResponseSerializer(encoding: encoding)
            let xmlString = try stringResponseSerializer.serialize(request: request, response: response, data: data, error: nil)
            XML = try XMLSerialization.xmlObject(withString: xmlString, using: encoding ?? .utf8, options: options)
            if let keyPath = keyPath, keyPath.isEmpty == false {
                XML = (XML as AnyObject?)?.value(forKeyPath: keyPath)
            }
        } catch {
            print(error)
            XML = nil
        }
        
        return XML
    }
    
    /// Adds a handler using a `XMLMappableResponseSerializer` to be called once the request has finished.
    ///
    /// - parameters:
    ///     - queue: The queue on which the completion handler is dispatched.
    ///     - keyPath: The key path where object mapping should be performed.
    ///     - dataPreprocessor: `DataPreprocessor` which processes the received `Data` before calling the `completionHandler`. `PassthroughPreprocessor()` by default.
    ///     - object: An object to perform the mapping on to.
    ///     - encoding: The string Encoding. Default value is UTF-8.
    ///     - emptyResponseCodes: HTTP status codes for which empty responses are always valid. `[204, 205]` by default.
    ///     - emptyRequestMethods: `HTTPMethod`s for which empty responses are always valid. `[.head]` by default.
    ///     - options: `XMLSerialization.ReadingOptions` used when parsing the response. `.default` by default.
    ///     - completionHandler: A closure to be executed once the request has finished and the data has been mapped by XMLMapper.
    ///
    /// - returns: The request.
    @discardableResult
    public func responseXMLObject<T: XMLBaseMappable>(
        queue: DispatchQueue = .main,
        keyPath: String? = nil,
        dataPreprocessor: DataPreprocessor = XMLMappableResponseSerializer<T>.defaultDataPreprocessor,
        mapToObject object: T? = nil,
        encoding: String.Encoding? = nil,
        emptyResponseCodes: Set<Int> = XMLMappableResponseSerializer<T>.defaultEmptyResponseCodes,
        emptyRequestMethods: Set<HTTPMethod> = XMLMappableResponseSerializer<T>.defaultEmptyRequestMethods,
        options: XMLSerialization.ReadingOptions = .default,
        completionHandler: @escaping (AFDataResponse<T>) -> Void
    ) -> Self {
        return response(
            queue: queue,
            responseSerializer: XMLMappableResponseSerializer<T>(
                dataPreprocessor: dataPreprocessor,
                emptyResponseCodes: emptyResponseCodes,
                emptyRequestMethods: emptyRequestMethods
            ) { request, response, data, error in
                let XMLObject = self.processResponse(request: request, response: response, data: data, keyPath: keyPath, encoding: encoding, options: options)
                
                if let object = object {
                    _ = XMLMapper<T>().map(XMLObject: XMLObject, toObject: object)
                    return object
                } else if let parsedObject = XMLMapper<T>().map(XMLObject: XMLObject) {
                    return parsedObject
                }
                
                throw AFError.responseSerializationFailed(reason: .decodingFailed(error: self.newError(.dataSerializationFailed)))
            },
            completionHandler: completionHandler
        )
    }
    
    /// Adds a handler using a `XMLMappableArrayResponseSerializer` to be called once the request has finished. T: XMLBaseMappable
    ///
    /// - parameters:
    ///     - queue: The queue on which the completion handler is dispatched.
    ///     - keyPath: The key path where object mapping should be performed.
    ///     - dataPreprocessor: `DataPreprocessor` which processes the received `Data` before calling the `completionHandler`. `PassthroughPreprocessor()` by default.
    ///     - encoding: The string Encoding. Default value is UTF-8.
    ///     - emptyResponseCodes: HTTP status codes for which empty responses are always valid. `[204, 205]` by default.
    ///     - emptyRequestMethods: `HTTPMethod`s for which empty responses are always valid. `[.head]` by default.
    ///     - options: `XMLSerialization.ReadingOptions` used when parsing the response. `.default` by default.
    ///     - completionHandler: A closure to be executed once the request has finished and the data has been mapped by XMLMapper.
    ///
    /// - returns: The request.
    @discardableResult
    public func responseXMLArray<T: XMLBaseMappable>(
        queue: DispatchQueue = .main,
        keyPath: String? = nil,
        dataPreprocessor: DataPreprocessor = XMLMappableArrayResponseSerializer<T>.defaultDataPreprocessor,
        encoding: String.Encoding? = nil,
        emptyResponseCodes: Set<Int> = XMLMappableArrayResponseSerializer<T>.defaultEmptyResponseCodes,
        emptyRequestMethods: Set<HTTPMethod> = XMLMappableArrayResponseSerializer<T>.defaultEmptyRequestMethods,
        options: XMLSerialization.ReadingOptions = .default,
        completionHandler: @escaping (AFDataResponse<[T]>) -> Void
    ) -> Self {
        return response(
            queue: queue,
            responseSerializer: XMLMappableArrayResponseSerializer(
                dataPreprocessor: dataPreprocessor,
                emptyResponseCodes: emptyResponseCodes,
                emptyRequestMethods: emptyRequestMethods
            ) { request, response, data, error in
                let XMLObject = self.processResponse(request: request, response: response, data: data, keyPath: keyPath, encoding: encoding, options: options)
                
                if let parsedObject = XMLMapper<T>().mapArray(XMLObject: XMLObject) {
                    return parsedObject
                }
                
                throw AFError.responseSerializationFailed(reason: .decodingFailed(error: self.newError(.dataSerializationFailed)))
            },
            completionHandler: completionHandler
        )
    }
}
