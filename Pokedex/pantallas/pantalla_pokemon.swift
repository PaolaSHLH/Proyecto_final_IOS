//
//  pantalla_pokemon.swift
//  Pokedex
//
//  Created by alumno on 19/5/25.
//

import SwiftUI
 
struct detallesPkm: View {
    @Environment(ControladorApi.self) var controlador
 
    // Colores temáticos por tipo
    let tipoColores: [String: Color] = [
        "normal": .gray, "fire": .red, "water": .blue, "electric": .yellow,
        "grass": .green, "ice": .cyan, "fighting": .orange, "poison": .purple,
        "ground": .brown, "flying": .mint, "psychic": .pink, "bug": .green,
        "rock": .gray, "ghost": .indigo, "dragon": .blue, "dark": .black,
        "steel": .gray, "fairy": .pink
    ]
 
    var body: some View {
        if let pokemon = controlador.pokemon_seleccionado {
            ScrollView {
                VStack(spacing: 20) {
                    // Imagen
                    AsyncImage(url: URL(string: pokemon.sprites.front_default ?? "")) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 150)
                    } placeholder: {
                        ProgressView()
                            .frame(width: 150, height: 150)
                    }
 
                    // Nombre y número
                    Text("#\(pokemon.id) \(pokemon.name.capitalized)")
                        .font(.title)
                        .bold()
 
                    // Altura y peso
                    HStack(spacing: 40) {
                        VStack {
                            Text("Altura")
                                .font(.caption)
                                .foregroundColor(.gray)
                            Text("\(pokemon.height)")
                        }
                        VStack {
                            Text("Peso")
                                .font(.caption)
                                .foregroundColor(.gray)
                            Text("\(pokemon.weight)")
                        }
                    }
 
                    // Tipos
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Tipos:")
                            .font(.headline)
                        HStack {
                            ForEach(pokemon.types, id: \.slot) { tipo in
                                Text(tipo.type.name.capitalized)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 6)
                                    .background(tipoColores[tipo.type.name, default: .gray].opacity(0.3))
                                    .foregroundColor(.black)
                                    .clipShape(Capsule())
                            }
                        }
                    }
 
                    // Habilidades
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Habilidades:")
                            .font(.headline)
                        ForEach(pokemon.abilities, id: \.ability.name) { habilidad in
                            Text(habilidad.ability.name.capitalized)
                                .italic()
                                .foregroundColor(habilidad.is_hidden ? .purple : .primary)
                        }
                    }
 
                    // Estadísticas
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Estadísticas:")
                            .font(.headline)
                        ForEach(pokemon.stats, id: \.stat.name) { stat in
                            HStack {
                                Text(stat.stat.name.capitalized)
                                    .frame(width: 100, alignment: .leading)
                                ProgressView(value: Float(stat.base_stat), total: 100)
                                    .tint(.green)
                                Text("\(stat.base_stat)")
                                    .frame(width: 40, alignment: .trailing)
                            }
                        }
                    }
 
                }
                .padding()
            }
            .navigationTitle(pokemon.name.capitalized)
            .navigationBarTitleDisplayMode(.inline)
        } else {
            VStack {
                Spacer()
                ProgressView("Cargando detalles...")
                Spacer()
            }
        }
    }
}

    #Preview {
        let controlador = ControladorApi()
        controlador.pokemon_seleccionado = Pokemon(
            id: 1,
            name: "bulbasaur",
            height: 7,
            weight: 69,
            types: [
                PokemonTypeEntry(slot: 1, type: NamedAPIResource(name: "grass", url: "")),
                PokemonTypeEntry(slot: 2, type: NamedAPIResource(name: "poison", url: ""))
            ],
            abilities: [
                PokemonAbilityEntry(is_hidden: false, ability: NamedAPIResource(name: "overgrow", url: ""))
            ],
            stats: [
                PokemonStatEntry(base_stat: 45, stat: NamedAPIResource(name: "hp", url: ""))
            ],
            sprites: PokemonSprites(front_default: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png")
        )
        return detallesPkm()
            .environment(controlador)
    }

