# XMLMapper

[![CI Status](http://img.shields.io/travis/gcharita/XMLMapper.svg?style=flat)](https://travis-ci.org/gcharita/XMLMapper)
[![Version](https://img.shields.io/cocoapods/v/XMLMapper.svg?style=flat)](http://cocoapods.org/pods/XMLMapper)
[![License](https://img.shields.io/cocoapods/l/XMLMapper.svg?style=flat)](http://cocoapods.org/pods/XMLMapper)
[![Platform](https://img.shields.io/cocoapods/p/XMLMapper.svg?style=flat)](http://cocoapods.org/pods/XMLMapper)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements
 - iOS 8.0+
 - Xcode 8.3+
 - Swift 3.1+

## How to use
To map the following xml:
```xml
 <?xml version="1.0" encoding="UTF-8"?>
 <root>
    <TestElementXMLMappable testAttribute="enumValue">
       <testString>Test string</testString>
       <testList>
          <element>
             <testInt>1</testInt>
             <testDouble>1.0</testDouble>
          </element>
          <element>
             <testInt>2</testInt>
             <testDouble>2.0</testDouble>
          </element>
          <element>
             <testInt>3</testInt>
             <testDouble>3.0</testDouble>
          </element>
          <element>
             <testInt>4</testInt>
             <testDouble>4.0</testDouble>
          </element>
       </testList>
    </TestElementXMLMappable>
 </root>
```
just implement XMLMappable protocol
```swift
class TestXMLMappable: XMLMappable {

    var testElement: TestElementXMLMappable!

    required init(map: XMLMap) {

    }

    func mapping(map: XMLMap) {
        testElement <- map["TestElementXMLMappable"]
    }
}

enum EnumTest: String {
    case theEnumValue = "enumValue"
}

class TestElementXMLMappable: XMLMappable {

    var testString: String?
    var testAttribute: EnumTest?
    var testList: [Element]?

    required init(map: XMLMap) {

    }

    func mapping(map: XMLMap) {
        testString <- map["testString"]
        testAttribute <- map.attributes["testAttribute"]
        testList <- map["testList.element"]
    }
}

class Element: XMLMappable {

    var testInt: Int?
    var testDouble: Float?

    required init(map: XMLMap) {

    }

    func mapping(map: XMLMap) {
        testInt <- map["testInt"]
        testDouble <- map["testDouble"]
    }
}
```
## Installation

XMLMapper is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'XMLMapper'
```

## Special thanks

 - Special thanks to [Hearst-DD](https://github.com/Hearst-DD). This project is based in  [ObjectMapper](https://github.com/Hearst-DD/ObjectMapper) for the most part, which is a great solution for JSON mapping
 - A special thanks to [Nick Lockwood](https://github.com/nicklockwood) and [XMLDictionary](https://github.com/nicklockwood/XMLDictionary) for the project dependency

## License

XMLMapper is available under the MIT license. See the LICENSE file for more info.
