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

    /// Utility function for checking for errors in response
    internal static func checkResponseForError(request: URLRequest?, response: HTTPURLResponse?, data: Data?, error: Error?) -> Error? {
        if let error = error {
            return error
        }
        guard let _ = data else {
            let failureReason = "Data could not be serialized. Input data was nil."
            let error = newError(.noData, failureReason: failureReason)
            return error
        }
        return nil
    }

    /// Utility function for extracting XML from response
    internal static func processResponse(request: URLRequest?, response: HTTPURLResponse?, data: Data?, keyPath: String?, encoding: String.Encoding?) -> Any? {
        let stringResponseSerializer = DataRequest.stringResponseSerializer(encoding: encoding)
        let result = stringResponseSerializer.serializeResponse(request, response, data, nil)
        
        var XML: Any?
        do {
            XML = try XMLSerialization.xmlObject(withString: result.value ?? "", using: encoding ?? .utf8)
            if let keyPath = keyPath, keyPath.isEmpty == false {
                XML = (XML as AnyObject?)?.value(forKeyPath: keyPath)
            }
        } catch let error {
            print(error)
            XML = nil
        }
        
        return XML
    }

    /// XMLBaseMappable Object Serializer
    public static func XMLMapperSerializer<T: XMLBaseMappable>(_ keyPath: String?, mapToObject object: T? = nil, encoding: String.Encoding? = nil) -> DataResponseSerializer<T> {
        return DataResponseSerializer { request, response, data, error in
            if let error = checkResponseForError(request: request, response: response, data: data, error: error){
                return .failure(error)
            }

            let XMLObject = processResponse(request: request, response: response, data: data, keyPath: keyPath, encoding: encoding)

            if let object = object {
                _ = XMLMapper<T>().map(XMLObject: XMLObject, toObject: object)
                return .success(object)
            } else if let parsedObject = XMLMapper<T>().map(XMLObject: XMLObject){
                return .success(parsedObject)
            }

            let failureReason = "XMLMapper failed to serialize response."
            let error = newError(.dataSerializationFailed, failureReason: failureReason)
            return .failure(error)
        }
    }

    /**
     Adds a handler to be called once the request has finished.

     - parameter queue:             The queue on which the completion handler is dispatched.
     - parameter keyPath:           The key path where object mapping should be performed
     - parameter object:            An object to perform the mapping on to
     - parameter completionHandler: A closure to be executed once the request has finished and the data has been mapped by XMLMapper.

     - returns: The request.
     */
    @discardableResult
    public func responseXMLObject<T: XMLBaseMappable>(queue: DispatchQueue? = nil, keyPath: String? = nil, mapToObject object: T? = nil, encoding: String.Encoding? = nil,  completionHandler: @escaping (DataResponse<T>) -> Void) -> Self {
        return response(queue: queue, responseSerializer: DataRequest.XMLMapperSerializer(keyPath, mapToObject: object, encoding: encoding), completionHandler: completionHandler)
    }

    /// XMLBaseMappable Array Serializer
    public static func XMLMapperArraySerializer<T: XMLBaseMappable>(_ keyPath: String?, encoding: String.Encoding? = nil) -> DataResponseSerializer<[T]> {
        return DataResponseSerializer { request, response, data, error in
            if let error = checkResponseForError(request: request, response: response, data: data, error: error){
                return .failure(error)
            }

            let XMLObject = processResponse(request: request, response: response, data: data, keyPath: keyPath, encoding: encoding)

            if let parsedObject = XMLMapper<T>().mapArray(XMLObject: XMLObject){
                return .success(parsedObject)
            }

            let failureReason = "XMLMapper failed to serialize response."
            let error = newError(.dataSerializationFailed, failureReason: failureReason)
            return .failure(error)
        }
    }

    /**
     Adds a handler to be called once the request has finished. T: XMLBaseMappable

     - parameter queue: The queue on which the completion handler is dispatched.
     - parameter keyPath: The key path where object mapping should be performed
     - parameter completionHandler: A closure to be executed once the request has finished and the data has been mapped by XMLMapper.

     - returns: The request.
     */
    @discardableResult
    public func responseXMLArray<T: XMLBaseMappable>(queue: DispatchQueue? = nil, keyPath: String? = nil, completionHandler: @escaping (DataResponse<[T]>) -> Void) -> Self {
        return response(queue: queue, responseSerializer: DataRequest.XMLMapperArraySerializer(keyPath), completionHandler: completionHandler)
    }
}

