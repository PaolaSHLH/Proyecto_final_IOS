//
//  controlador_api.swift
//  Pokedex
//
//  Created by alumno on 9/5/25.
//

import SwiftUI
 
@MainActor

@Observable

public class ControladorApi {

    var pokemones: [Pokemon] = []
    var pokemon_seleccionado: Pokemon? = nil
    var pagina_resultados_pokedex: PaginaResultadoPokedex? = nil
    var pagina_resultado_hab: PaginaResultadoHabilidades? = nil

    init() {
        Task {
            await cargarDatos()
        }

    }

    func cargarDatos() async {

        await withTaskGroup(of: Void.self) { group in
            group.addTask { await self.descargar_pokemones() }
            group.addTask { await self.descargar_habilidades() }
        }
    }

    func descargar_pokemones() async {
        do {
            let resultado = try await PokemonAPI().descargar_pagina_pokemons()
            self.pagina_resultados_pokedex = resultado
        } catch {
            print("Error al descargar pokemones: \(error)")
        }
    }

    func descargar_info_pkm(id: Int) async {
        do {
            let pokemon = try await PokemonAPI().descargar_informacion_pokemon(id: id)
            self.pokemon_seleccionado = pokemon
        } catch {
            print("Error al descargar info de pokemon \(id): \(error)")
        }
    }
    
    func seleccionar_pkm(_ pokemonResumen: PokemonResumen) async {
        await descargar_info_pkm(id: pokemonResumen.idNumber)
    }

    func descargar_habilidades() async {
        do {
            let datos = try await PokemonAPI().descargar_pagina_hab()
            self.pagina_resultado_hab = datos
        } catch {
            print("Error al descargar habilidades: \(error)")
        }
    }

}

 
