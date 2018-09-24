//
//  House.swift
//  Westeros
//
//  Created by Alexandre on 6/9/18.
//  Copyright © 2018 Alexandre. All rights reserved.
//

import Foundation

typealias Words = String

typealias Members = Set<Person>

final class House {
    let name: String
    let sigil: Sigil
    let words: Words
    let wikiUrl: URL
    private var _members: Members
    
    var sortedMembers: [Person] {
        return _members.sorted()
    }
    
    init(name: String, sigil: Sigil, words: Words, url: URL) {
        self.name = name
        self.sigil = sigil
        self.words = words
        self._members = Members()
        self.wikiUrl = url
    }
    
}

extension House {
    var count: Int {
        return _members.count
    }
    
    func add(person: Person) {
        // Check add the right person in the house
        guard self == person.house else {
            return
        }
        
        _members.insert(person)
    }
    
    func add(persons: Person...) {
        persons.forEach { add(person: $0)}
    }
    
}

extension House {
    var proxyForEquality: String {
        return "\(name)\(words)\(count)"
    }
    
    var proxyForComparison: String {
        return name.lowercased()
    }
}

extension House: Equatable {
    static func ==(lhs: House, rhs: House) -> Bool {
        return lhs.proxyForEquality == rhs.proxyForEquality
    }
}

extension House: Hashable {
    var hashValue: Int {
        return proxyForEquality.hashValue
    }
}

extension House: Comparable {
    static func < (lhs: House, rhs: House) -> Bool {
        return lhs.proxyForComparison < rhs.proxyForComparison
    }
}
