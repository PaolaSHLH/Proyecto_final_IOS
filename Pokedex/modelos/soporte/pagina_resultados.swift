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
