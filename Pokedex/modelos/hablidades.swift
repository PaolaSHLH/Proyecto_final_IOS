//
//  hablidades.swift
//  Pokedex
//
//  Created by alumno on 9/5/25.
//

import SwiftUI

struct Ability: Codable {
    var id: Int
    var name: String
    var effect_entries: [AbilityEffectEntry]
    var pokemon: [AbilityPokemon]
}
 
struct AbilityEffectEntry: Codable {
    var effect: String
    var short_effect: String
    var language: NamedAPIResource
}
 
struct AbilityPokemon: Codable {
    var pokemon: NamedAPIResource
}
 

