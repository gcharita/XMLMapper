//
//  XMLMappableArrayResponseSerializer.swift
//  XMLMapper
//
//  Created by Giorgos Charitakis on 26/6/20.
//

import Foundation
import Alamofire

public final class XMLMappableArrayResponseSerializer<T: XMLBaseMappable>: ResponseSerializer {
    public let emptyResponseCodes: Set<Int>
    public let emptyRequestMethods: Set<HTTPMethod>
    public let keyPath: String?
    public let serializeCallback: (_ request: URLRequest?, _ response: HTTPURLResponse?, _ data: Data?, _ error: Error?) throws -> [T]
    
    /// Creates an instance using the values provided.
    ///
    /// - Parameters:
    ///     - keyPath: The key path where object mapping should be performed
    ///     - emptyResponseCodes:  The HTTP response codes for which empty responses are allowed. Defaults to `[204, 205]`.
    ///     - emptyRequestMethods: The HTTP request methods for which empty responses are allowed. Defaults to `[.head]`.
    ///     - serializeCallback: Block that performs the serialization of the response Data into the provided type.
    ///     - request: URLRequest which was used to perform the request, if any.
    ///     - response: HTTPURLResponse received from the server, if any.
    ///     - data: Data returned from the server, if any.
    ///     - error: Error produced by Alamofire or the underlying URLSession during the request.
    public init(
        _ keyPath: String?,
        emptyResponseCodes: Set<Int> = XMLMappableArrayResponseSerializer.defaultEmptyResponseCodes,
        emptyRequestMethods: Set<HTTPMethod> = XMLMappableArrayResponseSerializer.defaultEmptyRequestMethods,
        serializeCallback: @escaping (_ request: URLRequest?, _ response: HTTPURLResponse?, _ data: Data?, _ error: Error?) throws -> [T]
    ) {
        self.emptyResponseCodes = emptyResponseCodes
        self.emptyRequestMethods = emptyRequestMethods
        
        self.keyPath = keyPath
        self.serializeCallback = serializeCallback
    }
    
    public func serialize(request: URLRequest?, response: HTTPURLResponse?, data: Data?, error: Error?) throws -> [T] {
        if let error = error { throw error }
        
        guard let data = data, !data.isEmpty else {
            guard emptyResponseAllowed(forRequest: request, response: response) else {
                throw AFError.responseSerializationFailed(reason: .inputDataNilOrZeroLength)
            }
            
            // TODO: FIX - Empty Response
            guard let emptyValue = Empty.value as? [T] else {
                throw AFError.responseSerializationFailed(reason: .invalidEmptyResponse(type: "\(T.self)"))
            }
            
            return emptyValue
        }
        return try serializeCallback(request, response, data, error)
    }
}
