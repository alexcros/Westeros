//
//  Repository.swift
//  Westeros
//
//  Created by Alexandre on 12/9/18.
//  Copyright © 2018 Alexandre. All rights reserved.
//

import UIKit

// Repo dp
final class Repository {
    static let local = LocalFactory()
}

// Custom protocol HouseFactory
protocol HouseFactory {
    typealias Filter = (House) -> Bool
    
    var houses: [House] { get }
    
    func house(named: String) -> House?
    // sintactic sugar
    func houses(filteredBy filter: Filter) -> [House]
}

// Factory dp
final class LocalFactory: HouseFactory {
    
    var houses : [House] {
        
        // Sigils
        let starkSigil = Sigil(image: UIImage(named: "codeIsComing")!, description: "Lobo Huargo")
        let lannisterSigil = Sigil(image: UIImage(named: "lannister.jpg")!, description: "Leon rampantes")
        let targaryanSigil = Sigil(image: UIImage(named: "targaryenSmall.jpg")!, description: "Dragon tricefalo")
        
        // URLs
        let starkUrl = URL(string: "https://awoiaf.westeros.org/index.php/House_Stark")!
        let lannisterkUrl = URL(string: "https://awoiaf.westeros.org/index.php/House_Lannister")!
        let targaryanUrl = URL(string: "https://awoiaf.westeros.org/index.php/House_Targaryen")!
        
        // Houses creation
        let starkHouse = House(name: "Stark", sigil: starkSigil, words: "Winter is coming", url: starkUrl)
        let lannisterHouse = House(name: "Lannister", sigil: lannisterSigil, words: "Oye mi rugido", url: lannisterkUrl)
        let targaryanHouse = House(name: "Targaryan", sigil: targaryanSigil, words: "fuego ty sangre", url: targaryanUrl)
        
        // Characters creation
        let robb = Person(name: "Robb", alias: "El joven lobo", house: starkHouse)
        let arya = Person(name: "Arya", house: starkHouse)
        let tyrion = Person(name: "Tyrion", alias: "el enano", house: lannisterHouse)
        let cersei = Person(name: "Cersei", house: lannisterHouse)
        let jaime = Person(name: "Jaime", alias: "el mata reyes", house: lannisterHouse)
        let dani = Person(name: "Daenerys", alias: "Madre de dragones", house:targaryanHouse)
        
        // Add characters to houses
        starkHouse.add(persons: arya,robb)
//        starkHouse.add(person: robb)
        
        lannisterHouse.add(persons: tyrion, jaime, cersei)
//        lannisterHouse.add(person: cersei)
//        lannisterHouse.add(person: jaime)
        
        targaryanHouse.add(person: dani)
        
        return [starkHouse, lannisterHouse, targaryanHouse].sorted()
    }
    
    func house(named name: String) -> House? {
        return houses.first { $0.name.uppercased() == name.uppercased() }
    }
    
    func houses(filteredBy: Filter) -> [House] {
        // collection filter
        return houses.filter(filteredBy)
    }
}
