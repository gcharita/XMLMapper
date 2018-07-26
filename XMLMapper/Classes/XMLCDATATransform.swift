//
//  XMLCDATATransform.swift
//  XMLMapper
//
//  Created by Giorgos Charitakis on 10/07/2018.
//

import Foundation

open class XMLCDATATransform: XMLTransformOf<String, [Data]> {
    public init(toXML: @escaping (String?) -> [Data]? = { (value: String?) -> [Data]? in
        guard let cdata = value?.data(using: .utf8) else {
            return nil
        }
        return [cdata]
    }) {
        let fromXML: ([Data]?) -> String? = { (cdata: [Data]?) -> String? in
            return cdata?.compactMap({ String(data: $0, encoding: .utf8) }).joined(separator: "\n")
        }
        super.init(fromXML: fromXML, toXML: toXML)
    }
}
