//
//  Dictionary+XMLDictionary.swift
//  Pods
//
//  Created by Giorgos Charitakis on 14/09/2017.
//
//

import Foundation
import XMLDictionary

extension Dictionary {
    var xmlString: String {
        return (self as NSDictionary).xmlString
    }
}
