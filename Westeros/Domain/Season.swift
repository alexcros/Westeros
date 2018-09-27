//
//  Season.swift
//  Westeros
//
//  Created by Alexandre on 24/9/18.
//  Copyright © 2018 Alexandre. All rights reserved.
//

import Foundation

typealias Episodes = Set<Episode>

final class Season {
    
    // MARK: - Properties
    let name: String
    let releaseDate: Date
    private var _episodes: Episodes
    
    // MARK: - Initialization
    init(name: String, releaseDate: Date) {

        self.name = name
        
        self.releaseDate = releaseDate
        
        _episodes = Episodes()
    }
    
}

extension Season {
    var count: Int {
        return _episodes.count
    }
    
    var sortedEpisodes: [Episode] {
        return _episodes.sorted()
    }
    
    func add(episode: Episode) {
        // Check correct episode in Season
        guard self == episode.season else {
            return
        }
        
        _episodes.insert(episode)
    }
    
    func added(episodes: [Episode]) {
        episodes.forEach { add(episode: $0)}
    }
    
}

// MARK: - Proxy
extension Season {
    var proxyForEquality: String {
        return "\(name)\(releaseDate)\(count)"
    }
    
    var proxyForComparison: String {
        return name.lowercased()
    }
}

// MARK: - Equatable
extension Season: Equatable {
    static func ==(lhs: Season, rhs: Season) -> Bool {
        return lhs.proxyForEquality == rhs.proxyForEquality
    }
}

// MARK: - Hashable
extension Season: Hashable {
    var hashValue: Int {
        return proxyForEquality.hashValue
    }
}

// MARK: - Comparable
extension Season: Comparable {
    static func < (lhs: Season, rhs: Season) -> Bool {
        return lhs.proxyForComparison < rhs.proxyForComparison
    }
}

// MARK: - CustomStringConvertible
extension Season: CustomStringConvertible {
    var description: String {
        return "\(name) \(releaseDate)"
    }
    
}
