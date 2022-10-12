//
//  CharacterObject.swift
//  RickAndMorty
//
//  Created by Konstantin Bratchenko on 14.09.2022.
//

import Foundation

enum Gender: String, Codable {
    case Female
    case Male
    case Genderless
    case unknown
}

struct Location: Codable {
    let name: String
}

enum Status: String, Codable {
    case Alive
    case Dead
    case unknown
}

struct CharacterObject: Codable {
    let id: Int
    let name: String
    let image: String
    let status: Status
    let species: String
    let gender: Gender
    let origin: Location
    let location: Location
    
}

struct Info: Codable {
    var next: String?
    var prev: String?
}

struct CharactersResponse: Codable {
    let info: Info
    let results: [CharacterObject]
}


