//
//  Episode.swift
//  Westeros
//
//  Created by Alexandre on 24/9/18.
//  Copyright © 2018 Alexandre. All rights reserved.
//

import Foundation

final class Episode {
    let name: String
    let broadcastDate: Date
    let season : Season
    
    init(name: String, broadcastDate: Date, season: Season) {
        self.name = name
        self.broadcastDate = broadcastDate
        self.season = season
    }
}

extension Episode {
    var fullName: String {
         return "\(name)\(season.name)"
    }
}

extension Episode {
    var proxyForEquality: String {
        return "\(name)"
    }
    
    var proxyForComparison: String {
        return fullName.lowercased()
    }
}

extension Episode: Hashable {
    var hashValue: Int {
        return proxyForEquality.hashValue
    }
}

extension Episode: Equatable {
    static func ==(lhs: Episode, rhs: Episode) -> Bool {
        return lhs.proxyForEquality == rhs.proxyForEquality
    }
}

extension Episode: Comparable {
    static func < (lhs: Episode, rhs: Episode) -> Bool {
        return lhs.proxyForComparison < rhs.proxyForComparison
    }
    
}

extension Episode: CustomStringConvertible {
    var description: String {
        return "(name: \(name)"
    }
}
