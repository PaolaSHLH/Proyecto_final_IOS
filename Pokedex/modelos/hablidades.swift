//
//  hablidades.swift
//  Pokedex
//
//  Created by alumno on 9/5/25.
//

import SwiftUI

struct Ability: Identifiable, Codable {
    let id: Int
    let name: String
    let effect_entries: [EffectEntry]
}
 
struct EffectEntry: Codable {
    let effect: String
    let short_effect: String
    let language: NamedAPIResource
}
