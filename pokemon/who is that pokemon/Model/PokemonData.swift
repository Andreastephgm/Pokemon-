//
//  PokemonData.swift
//  who is that pokemon
//
//  Created by Andrea Stefanny Garcia Mejia on 19/01/23.


import Foundation

// MARK: - PokemonData
struct PokemonData: Codable {
    let results: [Result]?
}

// MARK: - Result
struct Result: Codable {
    let name: String?
    let url: String?
}
