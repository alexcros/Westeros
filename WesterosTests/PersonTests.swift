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

    override func setUp() {
        starkSigil = Sigil(image: UIImage(), description: "Lobo guardo")
        starkHouse = House(name: "Stark", sigil: starkSigil, words: "Winter is coming...")
        
        //let url: URL = URL(string: "http://www.alexandrefreire.com")!
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testCharacterExistence() {

        let a = Person(name: "a", alias: "ned", house: starkHouse)
        
        XCTAssertNotNil(a)
    }

}
