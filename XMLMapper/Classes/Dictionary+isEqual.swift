//
//  Dictionary+isEqual.swift
//  XMLMapper
//
//  Created by Giorgos Charitakis on 19/10/2017.
//

import Foundation

func == <K, V>(left: [K: V], right: [K: V]) -> Bool {
    return NSDictionary(dictionary: left).isEqual(to: right)
}
