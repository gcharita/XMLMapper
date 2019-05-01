//
//  XMLMappable.swift
//  XMLMapper
//
//  Created by Giorgos Charitakis on 14/09/2017.
//
//

/// XMLBaseMappable should not be implemented directly. XMLMappable or XMLStaticMappable should be used instead
public protocol XMLBaseMappable {
    /// This property is where the name of the XML node is being mapped
    var nodeName: String! { get set }
    /// This function is where all variable mappings should occur. It is executed by XMLMapper during the mapping (serialization and deserialization) process.
    mutating func mapping(map: XMLMap)
}

extension XMLBaseMappable {
    /// Start mapping by map the XML nodeName first
    mutating func mapping(with map: XMLMap) {
        nodeName <- map[XMLParserConstant.Key.nodeName]
        mapping(map: map)
    }
}

public protocol XMLMappable: XMLBaseMappable {
    /// This function can be used to validate XML prior to mapping. Return nil to cancel mapping at this point
    init?(map: XMLMap)
}

public protocol XMLStaticMappable: XMLBaseMappable {
    /// This is function that can be used to:
    ///        1) provide an existing cached object to be used for mapping
    ///        2) return an object of another class (which conforms to XMLBaseMappable) to be used for mapping. For instance, you may inspect the XML to infer the type of object that should be used for any given mapping
    static func objectForMapping(map: XMLMap) -> XMLBaseMappable?
}

public extension XMLBaseMappable {
    
    /// Initializes object from a XML String
    init?(XMLString: String) {
        if let obj: Self = XMLMapper().map(XMLString: XMLString) {
            self = obj
        } else {
            return nil
        }
    }
    
    /// Initializes object from a XML Dictionary
    init?(XML: [String: Any]) {
        if let obj: Self = XMLMapper().map(XML: XML) {
            self = obj
        } else {
            return nil
        }
    }
    
    /// Returns the XML Dictionary for the object
    func toXML() -> [String: Any] {
        return XMLMapper().toXML(self)
    }
    
    /// Returns the XML String for the object
    func toXMLString() -> String? {
        return XMLMapper().toXMLString(self)
    }
}

public extension Array where Element: XMLBaseMappable {
    
    /// Initialize Array from a XML String
    init?(XMLString: String) {
        if let obj: [Element] = XMLMapper().mapArray(XMLString: XMLString) {
            self = obj
        } else {
            return nil
        }
    }
    
    /// Initialize Array from a XML Array
    init(XMLArray: [[String: Any]]) {
        let obj: [Element] = XMLMapper().mapArray(XMLArray: XMLArray)
        self = obj
    }
    
    /// Returns the XML Array
    func toXML() -> [[String: Any]] {
        return XMLMapper().toXMLArray(self)
    }
    
    /// Returns the XML String for the object
    func toXMLString() -> String? {
        return XMLMapper().toXMLString(self)
    }
}

public extension Set where Element: XMLBaseMappable {
    
    /// Initializes a set from a XML String
    init?(XMLString: String) {
        if let obj: Set<Element> = XMLMapper().mapSet(XMLString: XMLString) {
            self = obj
        } else {
            return nil
        }
    }
    
    /// Initializes a set from XML
    init?(XMLArray: [[String: Any]]) {
        guard let obj = XMLMapper().mapSet(XMLArray: XMLArray) as Set<Element>? else {
            return nil
        }
        self = obj
    }
    
    /// Returns the XML Set
    func toXML() -> [[String: Any]] {
        return XMLMapper().toXMLSet(self)
    }
    
    /// Returns the XML String for the object
    func toXMLString() -> String? {
        return XMLMapper().toXMLString(self)
    }
}
