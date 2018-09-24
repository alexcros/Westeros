//
//  RepositoryTests.swift
//  WesterosTests
//
//  Created by Alexandre on 12/9/18.
//  Copyright © 2018 Alexandre. All rights reserved.
//

import XCTest

@testable import Westeros
class RepositoryTests: XCTestCase {
    
    var localHouses: [House]!

    override func setUp() {
        localHouses = Repository.local.houses
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLocalRepositoryExistence() {
        XCTAssertNotNil(Repository.local)
    }
    
    func testLocalRepositoryHousesCreation() {
        
        XCTAssertNotNil(localHouses)
        
        XCTAssertEqual(localHouses.count, 3)
    }
    
    func testLocalRepository_ReturnsSortedArrayOfHouses() {
        XCTAssertEqual(localHouses, localHouses.sorted())
        
        
    }
    
    func testLocalRepo_returnsHousesByName_CaseInsensitively() {
        //let stark = Repository.local.houses(named: "sTark")
        let stark = Repository.local.house(named: "StArK")
        
        XCTAssertEqual(stark?.name, "Stark")
        
        let keepcoding = Repository.local.house(named: "keepcodimg")
        XCTAssertNil(keepcoding)
    }
    
    func testLocalRepositoryHouseFiltering() {
        // casa con miembros
        //let filtered = Repository.local.houses(filteredBy: { $0.count == 1})
//        let filtered = Repository.local.houses(filteredBy: {$0.count == 1})
        var filtered = Repository.local.houses {$0.count == 1}
        XCTAssertEqual(filtered.count, 1)
        
        // la casa no tiene miembros
        filtered = Repository.local.houses { $0.count == 100 }
        XCTAssertTrue(filtered.isEmpty)
        // XCTAssertEqual(filtered.count, 0)
    }
}
