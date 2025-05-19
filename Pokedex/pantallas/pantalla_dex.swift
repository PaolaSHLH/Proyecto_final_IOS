//
//  pantalla_dex.swift
//  Pokedex
//
//  Created by alumno on 19/5/25.
//

import SwiftUI
 
struct PantallaPokedex: View {
    @Environment(ControladorApi.self) var controlador
 
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 16) {
                    Text("Pokédex")
                        .font(.largeTitle)
                        .bold()
                        .padding(.top)
 
                    if let lista = controlador.pagina_resultados_pokedex?.items {
                        ForEach(lista.sorted(by: { $0.idNumber < $1.idNumber })) { pokemonResumen in
                            NavigationLink {
                                detallesPkm()
                            } label: {
                                HStack(spacing: 16) {
                                    AsyncImage(url: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(pokemonResumen.idNumber).png")) { imagen in
                                        imagen
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 50, height: 50)
                                    } placeholder: {
                                        ProgressView()
                                            .frame(width: 50, height: 50)
                                    }
 
                                    VStack(alignment: .leading) {
                                        Text("#\(pokemonResumen.idNumber)")
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                        Text(pokemonResumen.name.capitalized)
                                            .font(.headline)
                                    }
 
                                    Spacer()
                                }
                                .padding()
                                .background(Color(.systemGray6))
                                .cornerRadius(12)
                                .shadow(radius: 1)
                                .padding(.horizontal)
                            }
                            .simultaneousGesture(TapGesture().onEnded {
                                Task{
                                    await controlador.descargar_info_pkm(id: pokemonResumen.idNumber )
                                }
                            })
                        }
                    } else {
                        ProgressView("Cargando pokemones...")
                            .padding()
                    }
                }
            }
        }
    }
}
 
#Preview {
    PantallaPokedex()
        .environment(ControladorApi())
}

