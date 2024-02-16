//
//  RickMorty.swift
//  CoreDataExoRick1
//
//  Created by roman domasik on 09/02/2024.
//

import Foundation

struct RickMorty: Codable {
    let results: [Results]
}

struct Results: Codable {
    let id: Int
    let name: String
    let status: Status
    let species: Species
    let type: String
    let gender: Gender
    let origin, location: Location
    let image: String
    let episode: [String]
    let url: String
    let created: String
}

enum Gender: String, Codable {
    case female = "Female"
    case male = "Male"
    case unknown = "unknown"
}

struct Location: Codable {
    let name: String
    let url: String
}

enum Status: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}

enum Species: String, Codable {
    case alien = "Alien"
    case human = "Human"
}
