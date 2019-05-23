# Change Log

## [1.5.3](https://github.com/gcharita/XMLMapper/releases/tag/1.5.3) (2019-05-23)

- Fixed [#23](https://github.com/gcharita/XMLMapper/issues/23). Invalid XML string for tags with XML encoded values
- Closed [#24](https://github.com/gcharita/XMLMapper/issues/24). Fixed redundant modifier warnings
- Converted to swift 4.2

## [1.5.2](https://github.com/gcharita/XMLMapper/releases/tag/1.5.2) (2019-01-04)

- Closed [#15](https://github.com/gcharita/XMLMapper/issues/15). Removed `stripEmptyNodes` from default `ReadingOptions` of `XMLSerialization`
- Fixed [#18](https://github.com/gcharita/XMLMapper/issues/18). Added `nodesOrder` property in `XMLMap` to preserve or change the nodes ordering
- Fixed nested mapping for attributes in `XMLMap`

## [1.5.1](https://github.com/gcharita/XMLMapper/releases/tag/1.5.1) (2018-07-24)

- Added missing `XMLStaticMappable` protocol
- Improved required initializer in `XMLMappable` protocol
- Added some helpful comments

## [1.5.0](https://github.com/gcharita/XMLMapper/releases/tag/1.5.0) (2018-06-20)

- Added support for Swift 4.2 and Xcode 10. Fixed invalid redeclaration errors. (warnings will remain in Swift 4.1 compiler, due to the fact that IUO do not behave the same way as in Swift 4.2 compiler)
- Fixed `flatMap` deprecation warnings.
- Fixed support for Swift 3.0 and Xcode 8.3.
- Fixed `XMLSerialization` to support XMLs with XML declaration
- Improved `XMLMapper` to support mapping of dictionary of `XMLMappable` and dictionary of arrays of `XMLMappable` objects.
- `XMLSerialization` can now return array of dictionaries
- Added support to map enums with rawValue of `LosslessStringConvertible`.
- Added support to map array of `Any` with single element.
- Added tests that cover more than half of the project.

## [1.4.4](https://github.com/gcharita/XMLMapper/releases/tag/1.4.4) (2018-04-01)

- Fixed [#5](https://github.com/gcharita/XMLMapper/issues/5). Mapping Array of single object.
- Fixed [#8](https://github.com/gcharita/XMLMapper/issues/8). Threading problem in `XMLObjectParser` causing crash.

## [1.4.3](https://github.com/gcharita/XMLMapper/releases/tag/1.4.3) (2018-02-17)

- Fixed [#2](https://github.com/gcharita/XMLMapper/issues/2). Wrong XML String from nodes with attributes only.

## [1.4.2](https://github.com/gcharita/XMLMapper/releases/tag/1.4.2) (2018-02-04)

- Fixed changes that broke Swift 3.1 and Xcode 8.3 support
- Added `innerText` property in `XMLMap` to map directly the text of current XML node [#1](https://github.com/gcharita/XMLMapper/issues/1)
- General code improvements

## [1.4.1](https://github.com/gcharita/XMLMapper/releases/tag/1.4.1) (2018-01-25)

- Added Carthage support

## [1.4.0](https://github.com/gcharita/XMLMapper/releases/tag/1.4.0) (2018-01-04)

- Added Swift 4 support
- Added Swift Package Manager support
- Added CHANGELOG.md
- Fixed compilation warnings

## [1.3.0](https://github.com/gcharita/XMLMapper/releases/tag/1.3.0) (2017-11-05)

- Removed XMLDictionary dependency and replaced with Swift code
- Added `ReadingOptions` in `XMLSerialization`
- Added documentation in `XMLSerialization`
- Minor code improvements

## [1.2.0](https://github.com/gcharita/XMLMapper/releases/tag/1.2.0) (2017-10-12)

- Added Requests subspec for making xml requests with Alamofire
- Added classes for making SOAP request (supports SOAP v1.1 and v1.2)
- Minor code improvements

## [1.0.0](https://github.com/gcharita/XMLMapper/releases/tag/1.0.0) (2017-10-04)

- Added `nodeName` property in `XMLMappable` protocol
- Fixed compiler warnings
- Small improvements

## [0.1.0](https://github.com/gcharita/XMLMapper/releases/tag/0.1.0) (2017-09-27)

- Initial release
- Basic XML mapping