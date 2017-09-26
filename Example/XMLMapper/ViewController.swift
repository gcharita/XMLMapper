//
//  ViewController.swift
//  XMLMapper
//
//  Created by gcharita on 09/14/2017.
//  Copyright (c) 2017 gcharita. All rights reserved.
//

import UIKit
import XMLMapper

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let xml = "<root> <TestElementXMLMappable testAttribute=\"enumValue\"> <testString>Test string</testString> <testList> <element> <testInt>1</testInt> <testDouble>1.0</testDouble> </element> <element> <testInt>2</testInt> <testDouble>2.0</testDouble> </element> <element> <testInt>3</testInt> <testDouble>3.0</testDouble> </element> <element> <testInt>4</testInt> <testDouble>4.0</testDouble> </element> </testList> </TestElementXMLMappable> </root>"
        let object = XMLMapper<TestXMLMappable>().map(XMLString: xml)
        print(object?.testElement.testAttribute ?? "nil")
        print(object?.toXMLString() ?? "nil")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

