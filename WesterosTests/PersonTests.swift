//
//  CharacterTests.swift
//  WesterosTests
//
//  Created by Alexandre on 6/9/18.
//  Copyright © 2018 Alexandre. All rights reserved.
//

import XCTest
@testable import Westeros

class PersonTests: XCTestCase {
    
    var starkHouse: House!
    var starkSigil: Sigil!
    var ned: Person!
    var arya: Person!
    
    override func setUp() {
        starkSigil = Sigil(image: UIImage(), description: "Lobo guardo")
        
        let starkUrl = URL(string: "https://awoiaf.westeros.org/index.php/House_Stark")!
        //        let lannisterkUrl = URL(string: "https://awoiaf.westeros.org/index.php/House_Lannister")!
        //        let targaryanUrl = URL(string: "https://awoiaf.westeros.org/index.php/House_Targaryen")!
        starkHouse = House(name: "Stark", sigil: starkSigil, words: "Winter is coming...",url: starkUrl)
        ned = Person(name: "Eddard", alias: "Ned", house: starkHouse)
        arya = Person(name: "Aria", house: starkHouse)
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testCharacterExistence() {
        XCTAssertNotNil(ned)
        XCTAssertNotNil(arya)
    }
    
    func testPersonFullName() {
        XCTAssertEqual(ned.fullName, "Eddard Stark")
        XCTAssertEqual(arya.fullName, "Aria Stark")
    }
    
    func testPersonEquality() {
        // 1. Identity
        XCTAssertEqual(ned, ned)
        
        // 2. Equality
        let eddard = Person(name: "Eddard", alias: "Ned", house: starkHouse)
        XCTAssertEqual(eddard, ned)
        
        // 3. Inequality
        XCTAssertNotEqual(ned, arya)
        
    }
    
    func testPersonHashable() {
        XCTAssertNotNil(ned.hashValue)
    }
    
    func testPersonComparison() {
        XCTAssertGreaterThan(ned, arya)
        
    }
}
