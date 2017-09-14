//
//  XMLMapper.swift
//  Pods
//
//  Created by Giorgos Charitakis on 14/09/2017.
//
//

import Foundation

class XMLMapper<T: XMLMappable> {
//    public var context: MapContext?
//    public var shouldIncludeNilValues = false /// If this is set to true, toJSON output will include null values for any variables that are not set.
//    
//    public init(context: MapContext? = nil, shouldIncludeNilValues: Bool = false){
//        self.context = context
//        self.shouldIncludeNilValues = shouldIncludeNilValues
//    }
//    
//    // MARK: Mapping functions that map to an existing object toObject
//    
//    /// Maps a JSON object to an existing Mappable object if it is a JSON dictionary, or returns the passed object as is
//    public func map(JSONObject: Any?, toObject object: N) -> N {
//        if let JSON = JSONObject as? [String: Any] {
//            return map(JSON: JSON, toObject: object)
//        }
//        
//        return object
//    }
//    
//    /// Map a JSON string onto an existing object
//    public func map(JSONString: String, toObject object: N) -> N {
//        if let JSON = Mapper.parseJSONStringIntoDictionary(JSONString: JSONString) {
//            return map(JSON: JSON, toObject: object)
//        }
//        return object
//    }
//    
//    /// Maps a JSON dictionary to an existing object that conforms to Mappable.
//    /// Usefull for those pesky objects that have crappy designated initializers like NSManagedObject
//    public func map(JSON: [String: Any], toObject object: N) -> N {
//        var mutableObject = object
//        let map = Map(mappingType: .fromJSON, JSON: JSON, toObject: true, context: context, shouldIncludeNilValues: shouldIncludeNilValues)
//        mutableObject.mapping(map: map)
//        return mutableObject
//    }
//    
//    //MARK: Mapping functions that create an object
//    
//    /// Map a JSON string to an object that conforms to Mappable
//    public func map(JSONString: String) -> N? {
//        if let JSON = Mapper.parseJSONStringIntoDictionary(JSONString: JSONString) {
//            return map(JSON: JSON)
//        }
//        
//        return nil
//    }
//    
//    /// Maps a JSON object to a Mappable object if it is a JSON dictionary or NSString, or returns nil.
//    public func map(JSONObject: Any?) -> N? {
//        if let JSON = JSONObject as? [String: Any] {
//            return map(JSON: JSON)
//        }
//        
//        return nil
//    }
//    
//    /// Maps a JSON dictionary to an object that conforms to Mappable
//    public func map(JSON: [String: Any]) -> N? {
//        let map = Map(mappingType: .fromJSON, JSON: JSON, context: context, shouldIncludeNilValues: shouldIncludeNilValues)
//        
//        if let klass = N.self as? StaticMappable.Type { // Check if object is StaticMappable
//            if var object = klass.objectForMapping(map: map) as? N {
//                object.mapping(map: map)
//                return object
//            }
//        } else if let klass = N.self as? Mappable.Type { // Check if object is Mappable
//            if var object = klass.init(map: map) as? N {
//                object.mapping(map: map)
//                return object
//            }
//        } else if let klass = N.self as? ImmutableMappable.Type { // Check if object is ImmutableMappable
//            do {
//                return try klass.init(map: map) as? N
//            } catch let error {
//                #if DEBUG
//                    let exception: NSException
//                    if let mapError = error as? MapError {
//                        exception = NSException(name: .init(rawValue: "MapError"), reason: mapError.description, userInfo: nil)
//                    } else {
//                        exception = NSException(name: .init(rawValue: "ImmutableMappableError"), reason: error.localizedDescription, userInfo: nil)
//                    }
//                    exception.raise()
//                #else
//                    NSLog("\(error)")
//                #endif
//            }
//        } else {
//            // Ensure BaseMappable is not implemented directly
//            assert(false, "BaseMappable should not be implemented directly. Please implement Mappable, StaticMappable or ImmutableMappable")
//        }
//        
//        return nil
//    }
//    
//    // MARK: Mapping functions for Arrays and Dictionaries
//    
//    /// Maps a JSON array to an object that conforms to Mappable
//    public func mapArray(JSONString: String) -> [N]? {
//        let parsedJSON: Any? = Mapper.parseJSONString(JSONString: JSONString)
//        
//        if let objectArray = mapArray(JSONObject: parsedJSON) {
//            return objectArray
//        }
//        
//        // failed to parse JSON into array form
//        // try to parse it into a dictionary and then wrap it in an array
//        if let object = map(JSONObject: parsedJSON) {
//            return [object]
//        }
//        
//        return nil
//    }
//    
//    /// Maps a JSON object to an array of Mappable objects if it is an array of JSON dictionary, or returns nil.
//    public func mapArray(JSONObject: Any?) -> [N]? {
//        if let JSONArray = JSONObject as? [[String: Any]] {
//            return mapArray(JSONArray: JSONArray)
//        }
//        
//        return nil
//    }
//    
//    /// Maps an array of JSON dictionary to an array of Mappable objects
//    public func mapArray(JSONArray: [[String: Any]]) -> [N] {
//        // map every element in JSON array to type N
//        let result = JSONArray.flatMap(map)
//        return result
//    }
//    
//    /// Maps a JSON object to a dictionary of Mappable objects if it is a JSON dictionary of dictionaries, or returns nil.
//    public func mapDictionary(JSONString: String) -> [String: N]? {
//        let parsedJSON: Any? = Mapper.parseJSONString(JSONString: JSONString)
//        return mapDictionary(JSONObject: parsedJSON)
//    }
//    
//    /// Maps a JSON object to a dictionary of Mappable objects if it is a JSON dictionary of dictionaries, or returns nil.
//    public func mapDictionary(JSONObject: Any?) -> [String: N]? {
//        if let JSON = JSONObject as? [String: [String: Any]] {
//            return mapDictionary(JSON: JSON)
//        }
//        
//        return nil
//    }
//    
//    /// Maps a JSON dictionary of dictionaries to a dictionary of Mappable objects
//    public func mapDictionary(JSON: [String: [String: Any]]) -> [String: N]? {
//        // map every value in dictionary to type N
//        let result = JSON.filterMap(map)
//        if result.isEmpty == false {
//            return result
//        }
//        
//        return nil
//    }
//    
//    /// Maps a JSON object to a dictionary of Mappable objects if it is a JSON dictionary of dictionaries, or returns nil.
//    public func mapDictionary(JSONObject: Any?, toDictionary dictionary: [String: N]) -> [String: N] {
//        if let JSON = JSONObject as? [String : [String : Any]] {
//            return mapDictionary(JSON: JSON, toDictionary: dictionary)
//        }
//        
//        return dictionary
//    }
//    
//    /// Maps a JSON dictionary of dictionaries to an existing dictionary of Mappable objects
//    public func mapDictionary(JSON: [String: [String: Any]], toDictionary dictionary: [String: N]) -> [String: N] {
//        var mutableDictionary = dictionary
//        for (key, value) in JSON {
//            if let object = dictionary[key] {
//                _ = map(JSON: value, toObject: object)
//            } else {
//                mutableDictionary[key] = map(JSON: value)
//            }
//        }
//        
//        return mutableDictionary
//    }
//    
//    /// Maps a JSON object to a dictionary of arrays of Mappable objects
//    public func mapDictionaryOfArrays(JSONObject: Any?) -> [String: [N]]? {
//        if let JSON = JSONObject as? [String: [[String: Any]]] {
//            return mapDictionaryOfArrays(JSON: JSON)
//        }
//        
//        return nil
//    }
//    
//    ///Maps a JSON dictionary of arrays to a dictionary of arrays of Mappable objects
//    public func mapDictionaryOfArrays(JSON: [String: [[String: Any]]]) -> [String: [N]]? {
//        // map every value in dictionary to type N
//        let result = JSON.filterMap {
//            mapArray(JSONArray: $0)
//        }
//        
//        if result.isEmpty == false {
//            return result
//        }
//        
//        return nil
//    }
//    
//    /// Maps an 2 dimentional array of JSON dictionaries to a 2 dimentional array of Mappable objects
//    public func mapArrayOfArrays(JSONObject: Any?) -> [[N]]? {
//        if let JSONArray = JSONObject as? [[[String: Any]]] {
//            var objectArray = [[N]]()
//            for innerJSONArray in JSONArray {
//                let array = mapArray(JSONArray: innerJSONArray)
//                objectArray.append(array)
//            }
//            
//            if objectArray.isEmpty == false {
//                return objectArray
//            }
//        }
//        
//        return nil
//    }
//    
//    // MARK: Utility functions for converting strings to JSON objects
//    
//    /// Convert a JSON String into a Dictionary<String, Any> using NSJSONSerialization
//    public static func parseJSONStringIntoDictionary(JSONString: String) -> [String: Any]? {
//        let parsedJSON: Any? = Mapper.parseJSONString(JSONString: JSONString)
//        return parsedJSON as? [String: Any]
//    }
//    
//    /// Convert a JSON String into an Object using NSJSONSerialization
//    public static func parseJSONString(JSONString: String) -> Any? {
//        let data = JSONString.data(using: String.Encoding.utf8, allowLossyConversion: true)
//        if let data = data {
//            let parsedJSON: Any?
//            do {
//                parsedJSON = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
//            } catch let error {
//                print(error)
//                parsedJSON = nil
//            }
//            return parsedJSON
//        }
//        
//        return nil
//    }
}
