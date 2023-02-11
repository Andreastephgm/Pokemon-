//
//  ImageData.swift
//  who is that pokemon
//
//  Created by Andrea Stefanny Garcia Mejia on 19/01/23.
//


import Foundation

struct ImageData: Codable {
    let sprites: Sprites?

}


// MARK: - Sprites
class Sprites: Codable {
    
    let other: Other?
   

    init( other: Other?) {
        self.other = other
    }
}


// MARK: - OfficialArtwork
struct OfficialArtwork: Codable {
    let frontDefault, frontShiny: String?

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
        case frontShiny = "front_shiny"
    }
}




// MARK: - Other
struct Other: Codable {
    let officialArtwork: OfficialArtwork?

    enum CodingKeys: String, CodingKey {
        case officialArtwork = "official-artwork"
    }
}


