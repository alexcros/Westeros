//
//  EpisodeTests.swift
//  WesterosTests
//
//  Created by Alexandre on 24/9/18.
//  Copyright © 2018 Alexandre. All rights reserved.
//

import XCTest

@testable import Westeros
class EpisodeTests: XCTestCase {

    //let episode = Episode(name: "Episode 1", broadcastDate: Date.init(dateString: "2001-01-01"))
    let episode = Episode(name: "Episode 1", broadcastDate: Date.init(dateString: "2001-01-01"), season: Season(name: "Season 1", releaseDate: Date.init(dateString: "2000-01-01")))
    
    let episode2 = Episode(name: "Episode 2", broadcastDate: Date.init(dateString: "2001-01-01"), season: Season(name: "Season 1", releaseDate: Date.init(dateString: "2000-01-01")))
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testEpisodeExistence() {
        XCTAssertNotNil(episode)
    }

    func testEpisodeEquality() {
        XCTAssertEqual(episode, episode)
        
        let episodeEquality = Episode(name: "Episode 1",broadcastDate: Date.init(dateString: "2001-01-01"), season: Season(name: "Season 1", releaseDate: Date.init(dateString: "2000-01-01")))
        
        XCTAssertEqual(episodeEquality, episode)
        
        XCTAssertNotEqual(episode, episode2)
    }
    
    func testEpisodeHashable() {
        XCTAssertNotNil(episode.hashValue)
    }
    
    func testEpisodeComparison() {
        XCTAssertLessThan(episode, episode2)
    }
    
    func testEpisodeCustomStringConvertible() {
        XCTAssertEqual(episode.description, "description: Episode 1")
    }

}
