//
//  pokemon.swift
//  Pokedex
//
//  Created by alumno on 9/5/25.
//

import SwiftUI
 
enum Errores: Error {
    case badUrl
    case badResponse
    case badStatus
    case fallaAlConvertirLaRespuesta
    case invalidRequest
}
 
class PokemonAPI {
    let url_base = "https://pokeapi.co/api/v2/"
    // Descargar página de pokemones resumidos
    func descargar_pagina_pokemons() async throws -> PaginaResultadoPokedex {
        let ubicacion_recurso = "/pokemon?limit=649"
        return try await descargar(recurso: ubicacion_recurso)
    }
    
    // Descargar información completa de un pokemon
    func descargar_informacion_pokemon(id: Int) async throws -> Pokemon {
        return try await descargar(recurso: "pokemon/\(id)")
    }
    // Descargar página de habilidades
    func descargar_pagina_hab() async throws -> PaginaResultadoHabilidades {
        let ubicacion_recurso = "/ability?limit=251"
        return try await descargar(recurso: ubicacion_recurso)
    }
    // Descargar habilidad individual
    func descargar_habilidad(nombre: String) async throws -> Ability {
        let ubicacion_recurso = "/ability/\(nombre)"
        return try await descargar(recurso: ubicacion_recurso)
    }
    func descargar_pagina_mov() async throws -> PaginaResultadoMove{
        let ubicacion_recurso = "/move?limit=130"
        return try await descargar(recurso: ubicacion_recurso)
    }
    //descargar movimiento seleccionado individual
    func descargar_movimiento(nombre: String) async throws -> Move {
        let ubicacion_recurso = "/move/\(nombre)"
        return try await descargar(recurso: ubicacion_recurso)
        
    }
    
    // Función genérica para descargar y decodificar datos
    func descargar<TipoGenerico: Codable>(recurso: String) async throws -> TipoGenerico {
        guard let url = URL(string: "\(url_base)\(recurso)") else {
            throw ErroresDeRed.badUrl
        }
        let (datos, respuesta) = try await URLSession.shared.data(from: url)
        guard let respuestaHTTP = respuesta as? HTTPURLResponse else {
            throw ErroresDeRed.badResponse
        }
        guard (200..<300).contains(respuestaHTTP.statusCode) else {
            throw ErroresDeRed.badStatus
        }
        do {
            let resultado = try JSONDecoder().decode(TipoGenerico.self, from: datos)
            return resultado
        } catch {
            throw ErroresDeRed.fallaAlConvertirLaRespuesta
        }
    }
}
