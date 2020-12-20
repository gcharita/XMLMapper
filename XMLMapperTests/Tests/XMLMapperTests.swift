//
//  XMLMapperTests.swift
//  XMLMapperTests
//
//  Created by Giorgos Charitakis on 16/02/2018.
//

import XCTest
import Foundation
import XMLMapper

class XMLMapperTests: XCTestCase {
    
    let userMapper = XMLMapper<User>()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testBasicParsing() {
        let username = "John Doe"
        let identifier = "user8723"
        let photoCount = 13
        let age = 1227
        let weight = 123.23
        let float: Float = 123.231
        let drinker = true
        let smoker = false
        let sex: Sex = .female
        let canDrive = true
        let subUserXML = "<identifier>user8723</identifier><drinker>true</drinker><age>17</age><username>sub user</username><canDrive>\(canDrive)</canDrive>"
        
        let userXMLString = "<root><username>\(username)</username><identifier>\(identifier)</identifier><photoCount>\(photoCount)</photoCount><age>\(age)</age><drinker>\(drinker)</drinker><smoker>\(smoker)</smoker><sex>\(sex.rawValue)</sex><canDrive>\(canDrive)</canDrive><arr>bla</arr><arr>true</arr><arr>42</arr><dict><key1>value1</key1><key2>false</key2><key3>142</key3></dict><arrOpt>bla</arrOpt><arrOpt>true</arrOpt><arrOpt>42</arrOpt><dictOpt><key1>value1</key1><key2>false</key2><key3>142</key3></dictOpt><weight>\(weight)</weight><float>\(float)</float><friend>\(subUserXML)</friend><friendDictionary><bestFriend>\(subUserXML)</bestFriend></friendDictionary><friends>\(subUserXML)</friends><friends>\(subUserXML)</friends></root>"
        
        guard let user = userMapper.map(XMLString: userXMLString) else {
            XCTFail()
            return
        }
        
        XCTAssertNotNil(user)
        XCTAssertEqual(username, user.username)
        XCTAssertEqual(identifier, user.identifier)
        XCTAssertEqual(photoCount, user.photoCount)
        XCTAssertEqual(age, user.age)
        XCTAssertEqual(weight, user.weight)
        XCTAssertEqual(float, user.float)
        XCTAssertEqual(drinker, user.drinker)
        XCTAssertEqual(smoker, user.smoker)
        XCTAssertEqual(sex, user.sex)
        XCTAssertEqual(canDrive, user.canDrive)
        XCTAssertNotNil(user.friends)
        XCTAssertEqual(user.friends?.count, 2)
        XCTAssertEqual(user.friends?[1].canDrive, canDrive)
    }
    
    func testOptionalStringParsing() {
        let username = "John Doe"
        let identifier = "user8723"
        let photoCount = 13
        let age = 1227
        let weight = 123.23
        let float: Float = 123.231
        let drinker = true
        let smoker = false
        let sex: Sex = .female
        let subUserXML = "<identifier>user8723</identifier><drinker>true</drinker><age>17</age><username>sub user</username>"
        
        let userXMLString = "<root><username>\(username)</username><identifier>\(identifier)</identifier><photoCount>\(photoCount)</photoCount><age>\(age)</age><drinker>\(drinker)</drinker><smoker>\(smoker)</smoker><sex>\(sex.rawValue)</sex><arr>bla</arr><arr>true</arr><arr>42</arr><dict><key1>value1</key1><key2>false</key2><key3>142</key3></dict><arrOpt>bla</arrOpt><arrOpt>true</arrOpt><arrOpt>42</arrOpt><dictOpt><key1>value1</key1><key2>false</key2><key3>142</key3></dictOpt><weight>\(weight)</weight><float>\(float)</float><friend>\(subUserXML)</friend><friendDictionary><bestFriend>\(subUserXML)</bestFriend></friendDictionary></root>"
        
        let user = userMapper.map(XMLString: userXMLString)!
        
        XCTAssertNotNil(user)
        XCTAssertEqual(username, user.username)
        XCTAssertEqual(identifier, user.identifier)
        XCTAssertEqual(photoCount, user.photoCount)
        XCTAssertEqual(age, user.age)
        XCTAssertEqual(weight, user.weight)
        XCTAssertEqual(float, user.float)
        XCTAssertEqual(drinker, user.drinker)
        XCTAssertEqual(smoker, user.smoker)
        XCTAssertEqual(sex, user.sex)
    }
    
    func testInstanceParsing() {
        let username = "John Doe"
        let identifier = "user8723"
        let photoCount = 13
        let age = 1227
        let weight = 180.51
        let float: Float = 123.231
        let drinker = true
        let smoker = false
        let sex: Sex = .female
        let subUserXML = "<identifier>user8723</identifier><drinker>true</drinker><age>17</age><username>sub user</username>"
        
        let userXMLString = "<root><username>\(username)</username><identifier>\(identifier)</identifier><photoCount>\(photoCount)</photoCount><age>\(age)</age><drinker>\(drinker)</drinker><smoker>\(smoker)</smoker><sex>\(sex.rawValue)</sex><arr>bla</arr><arr>true</arr><arr>42</arr><dict><key1>value1</key1><key2>false</key2><key3>142</key3></dict><arrOpt>bla</arrOpt><arrOpt>true</arrOpt><arrOpt>42</arrOpt><dictOpt><key1>value1</key1><key2>false</key2><key3>142</key3></dictOpt><weight>\(weight)</weight><float>\(float)</float><friend>\(subUserXML)</friend><friendDictionary><bestFriend>\(subUserXML)</bestFriend></friendDictionary></root>"
        
        let user = XMLMapper().map(XMLString: userXMLString, toObject: User())
        
        XCTAssertEqual(username, user.username)
        XCTAssertEqual(identifier, user.identifier)
        XCTAssertEqual(photoCount, user.photoCount)
        XCTAssertEqual(age, user.age)
        XCTAssertEqual(weight, user.weight)
        XCTAssertEqual(float, user.float)
        XCTAssertEqual(drinker, user.drinker)
        XCTAssertEqual(smoker, user.smoker)
        XCTAssertEqual(sex, user.sex)
    }
    
    func testDictionaryParsing() {
        let name: String = "Genghis khan"
        let UUID: String = "12345"
        let major: Int = 99
        let minor: Int = 1
        let xml: [String: Any] = ["name": name, "UUID": UUID, "major": major.description]
        
        //test that the sematics of value types works as expected.  the resulting maped student
        //should have the correct minor property set even thoug it's not mapped
        var s = Student()
        s.minor = minor
        let student = XMLMapper().map(XML: xml, toObject: s)
        
        XCTAssertEqual(name, student.name)
        XCTAssertEqual(UUID, student.UUID)
        XCTAssertEqual(major, student.major)
        XCTAssertEqual(minor, student.minor)
        
        //Test that mapping a reference type works as expected while not relying on the return value
        let username: String = "Barack Obama"
        let identifier: String = "Political"
        let photoCount: Int = 1000000000
        
        let xml2: [String: Any] = ["username": username, "identifier": identifier, "photoCount": photoCount.description]
        let user = User()
        _ = XMLMapper().map(XML: xml2, toObject: user)
        
        XCTAssertEqual(username, user.username)
        XCTAssertEqual(identifier, user.identifier)
        XCTAssertEqual(photoCount, user.photoCount)
    }
    
    func testNullObject() {
        let XMLString = "<root><username>bob</username></root>"
        
        let user = userMapper.map(XMLString: XMLString)
        
        XCTAssertNotNil(user)
        XCTAssertNil(user?.age)
    }
    
    func testToXMLAndBack(){
        let user = User()
        user.username = "my_username"
        user.identifier = "my_identifier"
        user.photoCount = 0
        user.age = 28
        user.weight = 150
        user.drinker = true
        user.smoker = false
        user.sex = .female
        user.arr = ["cheese", 11234]
        
        let XMLString = XMLMapper().toXMLString(user)
        
        let parsedUser = userMapper.map(XMLString: XMLString!)!
        
        XCTAssertNotNil(parsedUser)
        XCTAssertEqual(user.identifier, parsedUser.identifier)
        XCTAssertEqual(user.photoCount, parsedUser.photoCount)
        XCTAssertEqual(user.age, parsedUser.age)
        XCTAssertEqual(user.weight, parsedUser.weight)
        XCTAssertEqual(user.drinker, parsedUser.drinker)
        XCTAssertEqual(user.smoker, parsedUser.smoker)
        XCTAssertEqual(user.sex, parsedUser.sex)
    }
    
    func testToXMLArrayAndBack(){
        let user = User()
        user.username = "my_username"
        user.identifier = "my_identifier"
        user.photoCount = 0
        user.age = 28
        user.weight = 150
        user.drinker = true
        user.smoker = false
        user.sex = .female
        user.arr = ["cheese", 11234]
        let users = [user, user, user]
        
        let XMLString = XMLMapper().toXMLString(users)
        
        let parsedUsers = userMapper.mapArray(XMLString: XMLString!)
        
        XCTAssertNotNil(parsedUsers)
        XCTAssertTrue(parsedUsers?.count == 3)
        XCTAssertEqual(user.identifier, parsedUsers?[0].identifier)
        XCTAssertEqual(user.photoCount, parsedUsers?[0].photoCount)
        XCTAssertEqual(user.age, parsedUsers?[0].age)
        XCTAssertEqual(user.weight, parsedUsers?[0].weight)
        XCTAssertEqual(user.drinker, parsedUsers?[0].drinker)
        XCTAssertEqual(user.smoker, parsedUsers?[0].smoker)
        XCTAssertEqual(user.sex, parsedUsers?[0].sex)
    }
    
    func testUnknownPropertiesIgnored() {
        let XMLString = "<root><username>bob</username><identifier>bob1987</identifier><foo>bar</foo><fooArr>1</fooArr><fooArr>2</fooArr><fooArr>3</fooArr><fooObj><baz>qux</baz></fooObj></root>"
        
        let user = userMapper.map(XMLString: XMLString)
        
        XCTAssertNotNil(user)
    }
    
    func testInvalidXMLResultsInNilObject() {
        let XMLString = "<root><username>bob</username><identifier>bob1987</identifier>" // missing ending tag
        
        let user = userMapper.map(XMLString: XMLString)
        
        XCTAssertNil(user)
    }
    
    func testMapArrayXML(){
        let name1 = "Bob"
        let name2 = "Jane"
        
        let XMLString = "<root><name>\(name1)</name><UUID>3C074D4B-FC8C-4CA2-82A9-6E9367BBC875</UUID><major>541</major><minor>123</minor></root><root><name>\(name2)</name><UUID>3C074D4B-FC8C-4CA2-82A9-6E9367BBC876</UUID><major>54321</major><minor>13</minor></root>"
        
        let students = XMLMapper<Student>().mapArray(XMLString: XMLString)
        
        XCTAssertTrue(students?.count ?? 0 > 0)
        XCTAssertTrue(students?.count == 2)
        XCTAssertEqual(students?[0].name, name1)
        XCTAssertEqual(students?[1].name, name2)
    }
    
    // test mapArray() with XML string that is not an array form
    // should return a collection with one item
    func testMapArrayXMLWithNoArray(){
        let name1 = "Bob"
        
        let XMLString = "<root><name>\(name1)</name><UUID>3C074D4B-FC8C-4CA2-82A9-6E9367BBC875</UUID><major>541</major><minor>123</minor></root>"
        
        let students = XMLMapper<Student>().mapArray(XMLString: XMLString)
        
        XCTAssertEqual(students?.count, 1)
        XCTAssertEqual(students?[0].name, name1)
    }
    
    func testArrayOfCustomObjects(){
        let percentage1: Double = 0.1
        let percentage2: Double = 1792.41
        
        let XMLString = "<root><tasks><taskId>103</taskId><percentage>\(percentage1)</percentage></tasks><tasks><taskId>108</taskId><percentage>\(percentage2)</percentage></tasks></root>"
        
        let plan = XMLMapper<Plan>().map(XMLString: XMLString)
        
        let tasks = plan?.tasks
        
        XCTAssertNotNil(tasks)
        XCTAssertEqual(tasks?[0].percentage, percentage1)
        XCTAssertEqual(tasks?[1].percentage, percentage2)
    }
    
    func testDictionaryOfArrayOfCustomObjects(){
        let percentage1: Double = 0.1
        let percentage2: Double = 1792.41
        
        let XMLString = "<root><dictionaryOfTasks><mondayTasks><taskId>103</taskId><percentage>\(percentage1)</percentage></mondayTasks><mondayTasks><taskId>108</taskId><percentage>\(percentage2)</percentage></mondayTasks></dictionaryOfTasks></root>"
        
        let plan = XMLMapper<Plan>().map(XMLString: XMLString)
        
        let dictionaryOfTasks = plan?.dictionaryOfTasks
        XCTAssertNotNil(dictionaryOfTasks)
        XCTAssertEqual(dictionaryOfTasks?["mondayTasks"]?[0].percentage, percentage1)
        XCTAssertEqual(dictionaryOfTasks?["mondayTasks"]?[1].percentage, percentage2)
        
        let planToXML = XMLMapper().toXMLString(plan!)
        
        let planFromXML = XMLMapper<Plan>().map(XMLString: planToXML!)
        
        let dictionaryOfTasks2 = planFromXML?.dictionaryOfTasks
        XCTAssertNotNil(dictionaryOfTasks2)
        XCTAssertEqual(dictionaryOfTasks2?["mondayTasks"]?[0].percentage, percentage1)
        XCTAssertEqual(dictionaryOfTasks2?["mondayTasks"]?[1].percentage, percentage2)
    }
    
    func testArrayOfEnumObjects(){
        let a: ExampleEnum = .a
        let b: ExampleEnum = .b
        let c: ExampleEnum = .c
        
        let XMLString = "<root><enums>\(a.rawValue)</enums><enums>\(b.rawValue)</enums><enums>\(c.rawValue)</enums></root>"
        
        let enumArray = XMLMapper<ExampleEnumArray>().map(XMLString: XMLString)
        let enums = enumArray?.enums
        
        XCTAssertNotNil(enums)
        XCTAssertTrue(enums?.count == 3)
        XCTAssertEqual(enums?[0], a)
        XCTAssertEqual(enums?[1], b)
        XCTAssertEqual(enums?[2], c)
    }
    
    func testDictionaryOfCustomObjects(){
        let percentage1: Double = 0.1
        let percentage2: Double = 1792.41
        
        let XMLString = "<root><tasks><task1><taskId>103</taskId><percentage>\(percentage1)</percentage></task1><task2><taskId>108</taskId><percentage>\(percentage2)</percentage></task2></tasks></root>"
        
        let taskDict = XMLMapper<TaskDictionary>().map(XMLString: XMLString)
        
        let task = taskDict?.tasks?["task1"]
        XCTAssertNotNil(task)
        XCTAssertEqual(task?.percentage, percentage1)
    }
    
    func testDictionryOfEnumObjects(){
        let a: ExampleEnum = .a
        let b: ExampleEnum = .b
        let c: ExampleEnum = .c
        
        let XMLString = "<root><enums><A>\(a.rawValue)</A><B>\(b.rawValue)</B><C>\(c.rawValue)</C></enums></root>"
        
        let enumDict = XMLMapper<ExampleEnumDictionary>().map(XMLString: XMLString)
        let enums = enumDict?.enums
        
        XCTAssertNotNil(enums)
        XCTAssertTrue(enums?.count == 3)
        XCTAssertEqual(enums?["A"], a)
        XCTAssertEqual(enums?["B"], b)
        XCTAssertEqual(enums?["C"], c)
    }
    
    func testDoubleParsing(){
        let percentage1: Double = 1792.41
        
        let XMLString = "<root><taskId>103</taskId><percentage>\(percentage1)</percentage></root>"
        
        let task = XMLMapper<Task>().map(XMLString: XMLString)
        
        XCTAssertNotNil(task)
        XCTAssertEqual(task?.percentage, percentage1)
    }
    
    func testToXMLArray(){
        let task1 = Task()
        task1.taskId = 1
        task1.percentage = 11.1
        let task2 = Task()
        task2.taskId = 2
        task2.percentage = 22.2
        let task3 = Task()
        task3.taskId = 3
        task3.percentage = 33.3
        
        let taskArray = [task1, task2, task3]
        
        let XMLArray = XMLMapper().toXMLArray(taskArray)
        
        let taskId1 = XMLArray[0]["taskId"] as? String
        let percentage1 = XMLArray[0]["percentage"] as? String
        
        XCTAssertEqual(taskId1, task1.taskId?.description)
        XCTAssertEqual(percentage1, task1.percentage?.description)
        
        let taskId2 = XMLArray[1]["taskId"] as? String
        let percentage2 = XMLArray[1]["percentage"] as? String
        
        XCTAssertEqual(taskId2, task2.taskId?.description)
        XCTAssertEqual(percentage2, task2.percentage?.description)
        
        let taskId3 = XMLArray[2]["taskId"] as? String
        let percentage3 = XMLArray[2]["percentage"] as? String
        
        XCTAssertEqual(taskId3, task3.taskId?.description)
        XCTAssertEqual(percentage3, task3.percentage?.description)
    }
    
    func testShouldPreventOverwritingMappableProperty() {
        let xml: [String: Any] = [
            "name": "Entry 1",
            "bigList": [["name": "item 1"], ["name": "item 2"], ["name": "item 3"]]
        ]
        let model = CachedModel()
        _ = XMLMapper().map(XML: xml, toObject: model)
        
        XCTAssertEqual(model.name, "Entry 1")
        XCTAssertEqual(model.bigList?.count, 3)
        
        let xml2: [String: Any] = ["name": "Entry 1"]
        _ = XMLMapper().map(XML: xml2, toObject: model)
        
        XCTAssertEqual(model.name, "Entry 1")
        XCTAssertEqual(model.bigList?.count, 3)
    }
}

class Status: XMLMappable {
    var nodeName: String!
    
    var status: Int?
    
    required init?(map: XMLMap){
        
    }
    
    func mapping(map: XMLMap) {
        status <- map["code"]
    }
}

class Plan: XMLMappable {
    var nodeName: String!
    
    var tasks: [Task]?
    var dictionaryOfTasks: [String: [Task]]?
    
    required init?(map: XMLMap){
        
    }
    
    func mapping(map: XMLMap) {
        tasks <- map["tasks"]
        dictionaryOfTasks <- map["dictionaryOfTasks"]
    }
}

class Task: XMLMappable {
    var nodeName: String!
    
    var taskId: Int?
    var percentage: Double?
    
    init(){
        
    }
    
    required init?(map: XMLMap){
        
    }
    
    func mapping(map: XMLMap) {
        taskId <- map["taskId"]
        percentage <- map["percentage"]
    }
}

class TaskDictionary: XMLMappable {
    var nodeName: String!
    
    var test: String?
    var tasks: [String : Task]?
    
    required init?(map: XMLMap){
        
    }
    
    func mapping(map: XMLMap) {
        test <- map["test"]
        tasks <- map["tasks"]
    }
}


// Confirm that struct can conform to `Mappable`
struct Student: XMLMappable {
    var nodeName: String!
    
    var name: String?
    var UUID: String?
    var major: Int?
    var minor: Int?
    
    init(){
        
    }
    
    init?(map: XMLMap){
        
    }
    
    mutating func mapping(map: XMLMap) {
        name <- map["name"]
        UUID <- map["UUID"]
        major <- map["major"]
        minor <- map["minor"]
    }
}

enum Sex: String {
    case male = "Male"
    case female = "Female"
}

class User: XMLMappable {
    var nodeName: String!
    
    
    var username: String = ""
    var identifier: String?
    var photoCount: Int = 0
    var age: Int?
    var weight: Double?
    var float: Float?
    var drinker: Bool = false
    var smoker: Bool?
    var sex: Sex?
    var canDrive: Bool?
    var arr: [Any] = []
    var arrOptional: [Any]?
    var dict: [String : Any] = [:]
    var dictOptional: [String : Any]?
    var dictString: [String : String]?
    var friendDictionary: [String : User]?
    var friend: User?
    var friends: [User]? = []
    
    init(){
        
    }
    
    required init?(map: XMLMap){
        
    }
    
    func mapping(map: XMLMap) {
        username         <- map["username"]
        identifier       <- map["identifier"]
        photoCount       <- map["photoCount"]
        age              <- map["age"]
        weight           <- map["weight"]
        float            <- map["float"]
        drinker          <- map["drinker"]
        smoker           <- map["smoker"]
        sex              <- map["sex"]
        canDrive         <- map["canDrive"]
        arr              <- map["arr"]
        arrOptional      <- map["arrOpt"]
        dict             <- map["dict"]
        dictOptional     <- map["dictOpt"]
        friend           <- map["friend"]
        friends          <- map["friends"]
        friendDictionary <- map["friendDictionary"]
        dictString         <- map["dictString"]
    }
}


enum ExampleEnum: Int {
    case a
    case b
    case c
}

class ExampleEnumArray: XMLMappable {
    var nodeName: String!
    
    var enums: [ExampleEnum] = []
    
    required init?(map: XMLMap){
        
    }
    
    func mapping(map: XMLMap) {
        enums <- map["enums"]
    }
}

class ExampleEnumDictionary: XMLMappable {
    var nodeName: String!
    
    var enums: [String: ExampleEnum] = [:]
    
    required init?(map: XMLMap){
        
    }
    
    func mapping(map: XMLMap) {
        enums <- map["enums"]
    }
}

class ArrayTest: XMLMappable {
    var nodeName: String!
    
    
    var twoDimensionalArray: Array<Array<Base>>?
    
    required init?(map: XMLMap){}
    
    func mapping(map: XMLMap) {
        twoDimensionalArray <- map["twoDimensionalArray"]
    }
}

class CachedModel: XMLMappable {
    var nodeName: String!
    
    var name: String?
    var bigList: [CachedItem]?
    
    init() {}
    
    required init?(map: XMLMap){}
    
    func mapping(map: XMLMap) {
        name <- map["name"]
        bigList <- map["bigList"]
    }
}

struct CachedItem: XMLMappable {
    var nodeName: String!
    
    var name: String?
    
    init?(map: XMLMap){}
    
    mutating func mapping(map: XMLMap) {
        name <- map["name"]
    }
}

