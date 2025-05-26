//
//  pantalla_hab_det.swift
//  Pokedex
//
//  Created by alumno on 19/5/25.
//

import SwiftUI
 
struct pantallaHabDet: View {
    @Environment(ControladorApi.self) var controlador
 
    var body: some View {
        if let habilidad = controlador.hab_seleccionada {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(LinearGradient(gradient: Gradient(colors: [Color.green.opacity(0.3), Color.teal.opacity(0.3)]), startPoint: .topLeading, endPoint: .bottomTrailing))
                            .frame(maxWidth: .infinity, minHeight: 100)
                            .shadow(radius: 4)
                        Text(habilidad.name.capitalized)
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(.primary)
                    }
 
                    VStack(alignment: .leading, spacing: 12) {
                        if let efecto = habilidad.effect_entries.first(where: { $0.language.name == "en" }) {
                            Text("🌀 Efecto:")
                                .font(.title3)
                                .bold()
                            Text(efecto.short_effect)
                                .font(.body)
                                .foregroundColor(.primary)
                        }
 
                        Divider()
 
                        if !habilidad.pokemon.isEmpty {
                            Text("🔗 Pokémon que la tienen:")
                                .font(.title3)
                                .bold()
                            VStack(alignment: .leading, spacing: 4) {
                                ForEach(habilidad.pokemon, id: \.pokemon.name) { poke in
                                    HStack {
                                        Circle()
                                            .fill(Color.teal.opacity(0.6))
                                            .frame(width: 8, height: 8)
                                        Text(poke.pokemon.name.capitalized)
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                    }
                                }
                            }
                        }
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color(.systemGray6))
                            .shadow(radius: 1)
                    )
                }
                .padding()
            }
            .navigationTitle("Habilidad")
            .navigationBarTitleDisplayMode(.inline)
        } else {
            ProgressView("Cargando...")
                .navigationTitle("Habilidad")
        }
    }
}

#Preview {
    let controlador = ControladorApi()
    controlador.hab_seleccionada = Ability(
        id: 1,
        name: "overgrow",
        effect_entries: [
            AbilityEffectEntry(
                effect: "Powers up Grass-type moves when the Pokémon is in trouble.",
                short_effect: "Strengthens Grass moves in a pinch.",
                language: NamedAPIResource(name: "en", url: "")
            ),
            AbilityEffectEntry(
                effect: "Aumenta los movimientos de tipo Planta cuando el Pokémon tiene poca salud.",
                short_effect: "Fortalece movimientos Planta en apuros.",
                language: NamedAPIResource(name: "es", url: "")
            )
        ],
        pokemon: [
            AbilityPokemon(pokemon: NamedAPIResource(name: "bulbasaur", url: "")),
            AbilityPokemon(pokemon: NamedAPIResource(name: "ivysaur", url: ""))
        ]
    )
 
    return pantallaHabDet()
        .environment(controlador)
}
