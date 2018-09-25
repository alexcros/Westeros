//
//  SeasonTests.swift
//  WesterosTests
//
//  Created by Alexandre on 24/9/18.
//  Copyright © 2018 Alexandre. All rights reserved.
//

import XCTest

@testable import Westeros
class SeasonTests: XCTestCase {

//    let season = Season(name: "Season 1", episodes: "array episodes", releaseDate: Date.init(dateString:"2000-01-01"))

    let season = Season(name: "Season 1", releaseDate: Date.init(dateString: "2000-01-01"))
    let season2 = Season(name: "Season 2", releaseDate: Date.init(dateString: "2000-01-01"))
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSeasonExistence() {
        XCTAssertNotNil(season)
    }
    
    func testSeasonEquality() {
        XCTAssertEqual(season, season)
        
        let seasonEquality = Season(name: "Season 1", releaseDate: Date.init(dateString: "2000-01-01"))
        XCTAssertEqual(seasonEquality, season)
        
        XCTAssertNotEqual(season, season2)
    }
    
    func testSeasonHashable() {
        XCTAssertNotNil(season.hashValue)
    }
    
    func testSeasonComparison() {
        XCTAssertLessThan(season, season2)
    }
    
    func testSeasonCustomStringConvertible() {
        XCTAssertEqual(season.description, "\(season.name) \(season.releaseDate)")
    }
    
}
