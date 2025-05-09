//
//  pokemon.swift
//  Pokedex
//
//  Created by alumno on 9/5/25.
//

import SwiftUI

struct Pokemon: Identifiable, Codable {
    let id: Int
    let name: String
    let height: Int
    let weight: Int
    let types: [PokemonTypeEntry]
    let abilities: [PokemonAbilityEntry]
    let stats: [PokemonStatEntry]
    let sprites: PokemonSprites
}
 
struct PokemonTypeEntry: Codable {
    let slot: Int
    let type: NamedAPIResource
}
 
struct PokemonAbilityEntry: Codable {
    let is_hidden: Bool
    let ability: NamedAPIResource
}
 
struct PokemonStatEntry: Codable {
    let base_stat: Int
    let stat: NamedAPIResource
}
 
struct PokemonSprites: Codable {
    let front_default: String?
}
 
struct NamedAPIResource: Codable {
    let name: String
    let url: String
}
