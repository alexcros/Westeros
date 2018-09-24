//
//  Season.swift
//  Westeros
//
//  Created by Alexandre on 24/9/18.
//  Copyright © 2018 Alexandre. All rights reserved.
//

import Foundation

typealias Episodes = String

final class Season {
    
    let name: String
    let episodes: Episodes
    let releaseDate: Date
    
    init(name: String, episodes: Episodes, releaseDate: Date) {

        self.name = name
        self.episodes = episodes
        self.releaseDate = releaseDate
        
    }
    
}
