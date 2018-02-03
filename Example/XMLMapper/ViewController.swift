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
        if let basicTestPath = Bundle.main.path(forResource: "basic_test", ofType: "xml") {
            do {
                let xml = try String(contentsOfFile: basicTestPath)
                let object = XMLMapper<TestXMLMappable>().map(XMLString: xml)
                print(object?.testElement.testAttribute ?? "nil")
                print(object?.toXMLString() ?? "nil")
            } catch {
                print("An error occurred reading resource basic_test.xml: \(error.localizedDescription)")
            }
        } else {
            print("Path for basic_test.xml not found")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

