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
    var localSeasons: [Season]!
    
    override func setUp() {
        localHouses = Repository.local.houses
        localSeasons = Repository.local.seasons
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
    
    func testLocalRepositorySeasonsCreation() {
        
        XCTAssertNotNil(localSeasons)
        
        XCTAssertEqual(localSeasons.count, 7)
    }
    
    func testLocalRepository_ReturnsSortedArrayOfHouses() {
        XCTAssertEqual(localHouses, localHouses.sorted())
        
    }
    
    func testLocalRepository_ReturnsSortedArrayOfSeasons() {
        XCTAssertEqual(localSeasons, localSeasons.sorted())
        
    }
    
    func testLocalRepo_returnsHousesByName_CaseInsensitively() {
        //let stark = Repository.local.houses(named: "sTark")
        let stark = Repository.local.house(named: "StArK")
        
        XCTAssertEqual(stark?.name, "Stark")
        
        let keepcoding = Repository.local.house(named: "keepcodimg")
        XCTAssertNil(keepcoding)
    }
    
    func testLocalRepository_returnsHousesWithMembersFiltering() {
        //let filtered = Repository.local.houses(filteredBy: { $0.count == 1})
        //        let filtered = Repository.local.houses(filteredBy: {$0.count == 1})
        var filteredMembers = Repository.local.houses {$0.count == 1}
        XCTAssertEqual(filteredMembers.count, 1)
        
        filteredMembers = Repository.local.houses { $0.count == 100 }
        XCTAssertTrue(filteredMembers.isEmpty)
    }
    
    func testLocalRepository_returnsSeasonsWithEpisodesFiltering() {
        var seasonsFiltered = Repository.local.seasons { $0.count == 2 }
        XCTAssertEqual(seasonsFiltered.count, 7)
        
        seasonsFiltered = Repository.local.seasons { $0.count == 3 }
        XCTAssertEqual(seasonsFiltered.count, 0)
    }
    
    func testLocalRepository_returnTypeSafeHouse() {
        let starkHouse = Repository.local.house(named: .stark)
        let lannisterHouse = Repository.local.house(named: .lannister)
        
        XCTAssertEqual("Stark", starkHouse?.name)
        
        XCTAssertNotEqual(starkHouse?.name, lannisterHouse?.name)
    }
}
