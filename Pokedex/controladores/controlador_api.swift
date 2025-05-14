//
//  controlador_api.swift
//  Pokedex
//
//  Created by alumno on 9/5/25.
//

import SwiftUI
 
@Observable
@MainActor
public class ControladorApi {
    var pokemones: [Pokemon] = []
    var pokemon_seleccionado: Pokemon? = nil
    var pagina_resultados_pokedex: PaginaResultadoPokedex? = nil
 
    // Se llama al inicializar el controlador
    init() {
        Task {
            await self.descargar_pokemones()
        }
    }
 
    // Descargar lista de pokémon resumida
    func descargar_pokemones() async {
        guard let resultado: PaginaResultadoPokedex = await PokemonAPI().descargar_pagina_pokemons() else { return }
        self.pagina_resultados_pokedex = resultado
    }
 
    // Descargar información completa de un pokémon por ID
    func descargar_info_pkm(id: Int) async {
        guard let pokimon: Pokemon = await PokemonAPI().descargar_informacion_pokemon(id: id) else { return }
        self.pokemon_seleccionado = pokimon
    }
 
    // Seleccionar un Pokémon del listado 
    func seleccionar_pkm(_ pokemonResumen: PokemonResumen) async {
        await descargar_info_pkm(id: pokemonResumen.idNumber)
    }
}
