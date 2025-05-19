//
//  pagina_resultados.swift
//  Pokedex
//
//  Created by alumno on 14/5/25.
//

import Foundation

struct Meta: Codable
{
    let totalItems: Int
    let itemCount: Int
    let itemsPerPage: Int
    let totalPages: Int
    let currentPage: Int
 
}
struct Enlaces: Codable
{
    let first: String
    let previous: String
    let next: String
    let last: String
}
//lista de pokedex
struct PokemonResumen: Identifiable, Codable {
    var id: String { name }
    let name: String
    let url: String
 
    var idNumber: Int {
        Int(url.split(separator: "/").last ?? "") ?? 0
    }
}
 
struct PaginaResultadoPokedex: Codable {
    let results: [PokemonResumen]
    var items: [PokemonResumen] {
        return results
    }
}
// lista Habilidades
struct PaginaResultadoHabilidades: Codable {
    let results: [HabilidadResumen]
    var items: [HabilidadResumen] {
        return results
    }
}
 
struct HabilidadResumen: Identifiable, Codable {
    var id: String { name }
    let name: String
    let url: String
}

//lista movimientos
struct MovResumen{
    var id: String {name}
    let name: String
    let url: String
}
