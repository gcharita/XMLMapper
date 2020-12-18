//
//  XMLMappableArrayResponseSerializer.swift
//  XMLMapper
//
//  Created by Giorgos Charitakis on 26/6/20.
//

import Foundation
import Alamofire

extension Array: EmptyResponse where Element: XMLBaseMappable & EmptyResponse {
    public static func emptyValue() -> Array {
        return []
    }
}

public final class XMLMappableArrayResponseSerializer<T: XMLBaseMappable>: ResponseSerializer {
    public let dataPreprocessor: DataPreprocessor
    public let emptyResponseCodes: Set<Int>
    public let emptyRequestMethods: Set<HTTPMethod>
    public let serializeCallback: (_ request: URLRequest?, _ response: HTTPURLResponse?, _ data: Data?, _ error: Error?) throws -> [T]
    
    /// Creates an instance using the values provided.
    ///
    /// - Parameters:
    ///     - dataPreprocessor: `DataPreprocessor` used to prepare the received `Data` for serialization.
    ///     - emptyResponseCodes: The HTTP response codes for which empty responses are allowed. Defaults to `[204, 205]`.
    ///     - emptyRequestMethods: The HTTP request methods for which empty responses are allowed. Defaults to `[.head]`.
    ///     - serializeCallback: Block that performs the serialization of the response Data into the provided type.
    ///     - request: URLRequest which was used to perform the request, if any.
    ///     - response: HTTPURLResponse received from the server, if any.
    ///     - data: Data returned from the server, if any.
    ///     - error: Error produced by Alamofire or the underlying URLSession during the request.
    public init(
        dataPreprocessor: DataPreprocessor = XMLMappableArrayResponseSerializer.defaultDataPreprocessor,
        emptyResponseCodes: Set<Int> = XMLMappableArrayResponseSerializer.defaultEmptyResponseCodes,
        emptyRequestMethods: Set<HTTPMethod> = XMLMappableArrayResponseSerializer.defaultEmptyRequestMethods,
        serializeCallback: @escaping (_ request: URLRequest?, _ response: HTTPURLResponse?, _ data: Data?, _ error: Error?) throws -> [T]
    ) {
        self.dataPreprocessor = dataPreprocessor
        self.emptyResponseCodes = emptyResponseCodes
        self.emptyRequestMethods = emptyRequestMethods
        self.serializeCallback = serializeCallback
    }
    
    public func serialize(request: URLRequest?, response: HTTPURLResponse?, data: Data?, error: Error?) throws -> [T] {
        if let error = error { throw error }
        
        guard let data = data, !data.isEmpty else {
            guard emptyResponseAllowed(forRequest: request, response: response) else {
                throw AFError.responseSerializationFailed(reason: .inputDataNilOrZeroLength)
            }
            
            guard let emptyResponseType = [T].self as? EmptyResponse.Type, let emptyValue = emptyResponseType.emptyValue() as? [T] else {
                throw AFError.responseSerializationFailed(reason: .invalidEmptyResponse(type: "\([T].self)"))
            }
            
            return emptyValue
        }
        return try serializeCallback(request, response, data, error)
    }
}
