//
//  Character.swift
//  Westeros
//
//  Created by Alexandre on 6/9/18.
//  Copyright © 2018 Alexandre. All rights reserved.
//

import Foundation

final class Person {
    
    // MARK: - Properties
    let name: String
    let house: House
    private let _alias: String?
    
    var alias: String {
        get {
//            if let _alias = _alias {
//                // Existe y esta guardado dentro de alias
//                return _alias
//            } else {
//                return ""
//            }
            return _alias ?? "" // modern ternary operator
        }
    }
    
    // MARK: - Initialization
    init(name: String, alias: String, house: House) {
        self.name = name
        _alias = alias
        self.house = house
    }
    
    init(name: String, house: House) {
        self.name = name
        self.house = house
        _alias = nil
    }
}
