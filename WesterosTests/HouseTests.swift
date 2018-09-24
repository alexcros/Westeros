//
//  HouseTests.swift
//  WesterosTests
//
//  Created by Alexandre on 6/9/18.
//  Copyright © 2018 Alexandre. All rights reserved.
//

import XCTest
@testable import Westeros

class HouseTests: XCTestCase {

    var starkSigil: Sigil!
    var lannisterSigil: Sigil!
    
    var starkHouse: House!
    var lannisterHouse: House!
    
    var robb: Person!
    var aria: Person!
    var tyrion: Person!
    
    override func setUp() {
            // Init properties
//        starkHouse = Repository.local.house(named: "Stark") // NO
//        lannisterHouse = Repository.local.house(named: "Lannister") // NO
        let starkUrl = URL(string: "https://awoiaf.westeros.org/index.php/House_Stark")!
        let lannisterUrl = URL(string: "https://awoiaf.westeros.org/index.php/House_Lannister")!
        
        starkSigil = Sigil(image: UIImage(), description: "Wolf")
        lannisterSigil = Sigil(image: UIImage(), description: "Rampant Lion")
        
        starkHouse = House(name: "Stark", sigil: starkSigil, words: "Winter is coming", url: starkUrl)
        lannisterHouse = House(name: "Lannister", sigil: lannisterSigil, words: "Hear my roar", url: lannisterUrl)
        
        robb = Person(name: "Robb", alias: "El joven lobo", house: starkHouse)
        aria = Person(name: "Aria", house: starkHouse)
        
        tyrion = Person(name: "Tyrion", alias: "El joven Lobo", house: lannisterHouse)
    }

    // Finish execute
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testHouseExistence() {
        XCTAssertNotNil(starkHouse)
    }
    
    func testSigilExistence() {
        XCTAssertNotNil(starkSigil)

        XCTAssertNotNil(lannisterSigil)
    }
    
    //  Given - When - Then
    func testHouse_AddPersons_ReturnsTheCorrectCountOfPersons() {
        XCTAssertEqual(starkHouse.count, 0)
        starkHouse.add(person: robb)
        starkHouse.add(person: robb)
        starkHouse.add(person: robb)

        XCTAssertEqual(starkHouse.count, 1)
        
        starkHouse.add(person: aria)

        XCTAssertEqual(starkHouse.count, 2)
        
        starkHouse.add(persons: tyrion, robb, tyrion)
        
        XCTAssertEqual(starkHouse.count, 2)
        
    }
    
    func testHouse_AddBunchOfPersons_ReturnsTheCorrectCountOfPersons() {
        XCTAssertEqual(starkHouse.count, 0)
        starkHouse.add(persons: robb, aria, tyrion)
        
        XCTAssertEqual(starkHouse.count, 2)
    }

    func testHouseEquality() {
        // 1. Identity
        XCTAssertEqual(starkHouse, starkHouse)
        
        // 2. Equality
        let starkUrl = URL(string: "https://awoiaf.westeros.org/index.php/House_Stark")!
        let jinxed = House(name: "Stark", sigil: starkSigil, words: "Winter is coming", url: starkUrl)
        XCTAssertEqual(jinxed, starkHouse)
        
        // 3. Inequality
        XCTAssertNotEqual(starkHouse, lannisterHouse)
        
    }
    
    func testHouseHashable() { // verify hashValue
        XCTAssertNotNil(starkHouse.hashValue) // exists
    }
    
    func testHouseComparison() { // sorted
        XCTAssertLessThan(lannisterHouse, starkHouse)
    }
    
    func testHouseSortedMembersReturnsASortedArray() {
        
    }
    
    // TEST QUE COMPRUEBA QUE ESTOS MIEMBROS VIENEN ORDENADOS
}
