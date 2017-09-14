//
//  ViewController.swift
//  XMLMapper
//
//  Created by gcharita on 09/14/2017.
//  Copyright (c) 2017 gcharita. All rights reserved.
//

import UIKit
import XMLMapper
import XMLDictionary

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        XMLDictionaryParser.sharedInstance().dictionary(with: "")
        let xml = "<root><TestElementXMLMappable testAttribute=\"Test attribute\"><testString>Test string</testString></TestElementXMLMappable></root>"
        let object = XMLMapper<TestXMLMappable>().map(XMLString: xml)
        print(object?.testElement.testAttribute ?? "nil")
        print(object?.toXMLString() ?? "nil")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

