//
//  pokemon.swift
//  Pokedex
//
//  Created by alumno on 9/5/25.
//

import SwiftUI
 
class PokemonAPI: Codable {
    let url_base = "https://pokeapi.co/api/v2/"
 
    func descargar_pagina_pokemons() async -> PaginaResultadoPokedex? {
        let ubicacion_recurso = "/pokemon?limit=251"
        return await descargar(recurso: ubicacion_recurso)
    }
 
    func descargar_informacion_pokemon(id: Int) async -> Pokemon? {
        return await descargar(recurso: "pokemon/\(id)")
    }
 
    func descargar<TipoGenerico: Codable>(recurso: String) async -> TipoGenerico? {
        do {
            guard let url = URL(string: "\(url_base)\(recurso)") else { throw ErroresDeRed.badUrl }
            let (datos, respuesta) = try await URLSession.shared.data(from: url)
            guard let respuesta = respuesta as? HTTPURLResponse else { throw ErroresDeRed.badResponse }
            guard respuesta.statusCode >= 200 && respuesta.statusCode < 300 else { throw ErroresDeRed.badStatus }
 
            let respuesta_decodificada = try JSONDecoder().decode(TipoGenerico.self, from: datos)
            return respuesta_decodificada
 
        } catch ErroresDeRed.badUrl {
            print("Tienes mala conexión.")
        } catch ErroresDeRed.badResponse {
            print("Error en la respuesta.")
        } catch ErroresDeRed.badStatus {
            print("Error de status.")
        } catch ErroresDeRed.fallaAlConvertirLaRespuesta {
            print("Error al convertir datos.")
        } catch ErroresDeRed.invalidRequest {
            print("Petición inválida.")
        } catch let error as NSError {
            print("Error de modelo: \(error.debugDescription)")
        } catch {
            print("Error desconocido.")
        }
 
        return nil
    }
}
