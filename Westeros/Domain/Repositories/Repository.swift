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

// MARK: - HouseFactory
protocol HouseFactory {
    typealias Filter = (House) -> Bool
    typealias FilterSeason = (Season) -> Bool
    
    var houses: [House] { get }
    var seasons: [Season] { get }
    
    func house(named: String) -> House?
    func season(named: String) -> Season?
    
    func houses(filteredBy filter: Filter) -> [House]
    func seasons(filteredBy filter: FilterSeason) -> [Season]
}

final class LocalFactory: HouseFactory {
    
    var seasons: [Season] {
        
        let season1 = Season(name: "Season 1", releaseDate: Date.init(dateString: "2011-04-11"))
        let season2 = Season(name: "Season 2", releaseDate: Date.init(dateString: "2012-04-11"))
        let season3 = Season(name: "Season 3", releaseDate: Date.init(dateString: "2013-04-11"))
        let season4 = Season(name: "Season 4", releaseDate: Date.init(dateString: "2014-04-11"))
        let season5 = Season(name: "Season 5", releaseDate: Date.init(dateString: "2015-04-11"))
        let season6 = Season(name: "Season 6", releaseDate: Date.init(dateString: "2016-04-11"))
        let season7 = Season(name: "Season 7", releaseDate: Date.init(dateString: "2017-04-11"))
        
        var allSeasons = [Season]()
        allSeasons.append(season1)
        allSeasons.append(season6)
        allSeasons.append(season3)
        allSeasons.append(season4)
        allSeasons.append(season7)
        allSeasons.append(season5)
        allSeasons.append(season2)
        
        var episodes = [Episode]()
        episodes.append(Episode(name: "Episode 1",
                                broadcastDate: Date.init(dateString:"2011-04-11"),
                                season: season1))
        episodes.append(Episode(name: "Episode 2",
                                broadcastDate: Date.init(dateString:"2011-04-11"),
                                season: season1))
        episodes.append(Episode(name: "Episode 1",
                                broadcastDate: Date.init(dateString:"2011-04-11"),
                                season: season2))
        episodes.append(Episode(name: "Episode 2",
                                broadcastDate: Date.init(dateString:"2011-04-11"),
                                season: season2))
        episodes.append(Episode(name: "Episode 1",
                                broadcastDate: Date.init(dateString:"2011-04-11"),
                                season: season3))
        episodes.append(Episode(name: "Episode 2",
                                broadcastDate: Date.init(dateString:"2011-04-11"),
                                season: season3))
        episodes.append(Episode(name: "Episode 1",
                                broadcastDate: Date.init(dateString:"2011-04-11"),
                                season: season4))
        episodes.append(Episode(name: "Episode 2",
                                broadcastDate: Date.init(dateString:"2011-04-11"),
                                season: season4))
        episodes.append(Episode(name: "Episode 1",
                                broadcastDate: Date.init(dateString:"2011-04-11"),
                                season: season5))
        episodes.append(Episode(name: "Episode 2",
                                broadcastDate: Date.init(dateString:"2011-04-11"),
                                season: season5))
        episodes.append(Episode(name: "Episode 1",
                                broadcastDate: Date.init(dateString:"2011-04-11"),
                                season: season6))
        episodes.append(Episode(name: "Episode 2",
                                broadcastDate: Date.init(dateString:"2011-04-11"),
                                season: season6))
        episodes.append(Episode(name: "Episode 1",
                                broadcastDate: Date.init(dateString:"2011-04-11"),
                                season: season7))
        episodes.append(Episode(name: "Episode 2",
                                broadcastDate: Date.init(dateString:"2011-04-11"),
                                season: season7))
        
        for season in allSeasons {
            season.added(episodes: episodes)
        }
        
        return allSeasons.sorted()
    }
    
    func season(named name: String) -> Season? {
        return seasons.first { $0.name.lowercased() == name.lowercased() }
    }
    
    func seasons(filteredBy: FilterSeason) -> [Season] {   
        return seasons.filter(filteredBy)
    }
    
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
