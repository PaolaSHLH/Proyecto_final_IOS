//
//  movimientos.swift
//  Pokedex
//
//  Created by alumno on 9/5/25.
//

import SwiftUI

struct Move: Identifiable, Codable {
    let id: Int
    let name: String
    let accuracy: Int?
    let power: Int?
    let pp: Int?
    let type: NamedAPIResource
    let damage_class: NamedAPIResource
    let effect_entries: [EffectEntry]
}
struct EffectEntry: Codable {
    let effect: String
    let short_effect: String
    let language: NamedAPIResource
}
