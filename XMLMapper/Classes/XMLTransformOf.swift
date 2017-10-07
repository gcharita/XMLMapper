//
//  XMLTransformOf.swift
//  XMLMapper
//
//  Created by Giorgos Charitakis on 14/09/2017.
//
//

open class XMLTransformOf<ObjectType, XMLType>: XMLTransformType {
    public typealias Object = ObjectType
    public typealias XML = XMLType
    
    private let fromXML: (XMLType?) -> ObjectType?
    private let toXML: (ObjectType?) -> XMLType?
    
    public init(fromXML: @escaping(XMLType?) -> ObjectType?, toXML: @escaping(ObjectType?) -> XMLType?) {
        self.fromXML = fromXML
        self.toXML = toXML
    }
    
    open func transformFromXML(_ value: Any?) -> ObjectType? {
        return fromXML(value as? XMLType)
    }
    
    open func transformToXML(_ value: ObjectType?) -> XMLType? {
        return toXML(value)
    }
}
