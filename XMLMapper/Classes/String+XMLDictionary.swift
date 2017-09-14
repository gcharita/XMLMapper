//
//  String+XMLDictionary.swift
//  Pods
//
//  Created by Giorgos Charitakis on 14/09/2017.
//
//

import Foundation
import XMLDictionary

extension String {
    var xmlEncoded: String {
        return (self as NSString).xmlEncoded
    }
}
