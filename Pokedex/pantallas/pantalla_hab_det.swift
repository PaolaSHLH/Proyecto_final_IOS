//
//  pantalla_hab_det.swift
//  Pokedex
//
//  Created by alumno on 19/5/25.
//

import SwiftUI

struct pantallaHabDet: View {
    var habilidad: Ability
     
        var body: some View {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text(habilidad.name.capitalized)
                        .font(.largeTitle)
                        .bold()
                        .padding(.bottom, 8)
     
                    if let efecto = habilidad.effect_entries.first(where: { $0.language.name == "en" }) {
                        Text("🌀 Efecto:")
                            .font(.headline)
                        Text(efecto.short_effect)
                            .font(.body)
                    }
     
                    if let efectoEsp = habilidad.effect_entries.first(where: { $0.language.name == "es" }) {
                        Text("🌐 Descripción (Español):")
                            .font(.headline)
                        Text(efectoEsp.short_effect)
                            .font(.body)
                    }
     
                    if !habilidad.pokemon.isEmpty {
                        Text("🔗 Pokémon que la tienen:")
                            .font(.headline)
     
                        ForEach(habilidad.pokemon, id: \.pokemon.name) { poke in
                            Text("• \(poke.pokemon.name.capitalized)")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Habilidad")
            .navigationBarTitleDisplayMode(.inline)
        }
}

#Preview {
    pantallaHabDet()
}
