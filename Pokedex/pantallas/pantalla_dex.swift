//
//  pantalla_dex.swift
//  Pokedex
//
//  Created by alumno on 19/5/25.
//

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

            ZStack {
                // Fondo general de la pantalla

                Image("fondo_listD")
                    .resizable()
                    .ignoresSafeArea()
                    .opacity(0.9)
 
                ScrollView {
                    LazyVStack(spacing: 18) {
                        // Título
                        Text("Pokédex")
                            .font(.largeTitle)
                            .bold()
                            .padding(.top)
                            .foregroundColor(.white)
                        // Lista de Pokémon
                        if let lista = controlador.pagina_resultados_pokedex?.items {
                            ForEach(lista.sorted(by: { $0.idNumber < $1.idNumber })) { pokemonResumen in
                                NavigationLink {
                                    detallesPkm()
                                } label: {
                                    ZStack {
                                        Image("item")
                                            .resizable()
                                            .frame(height: 80)
                                            .cornerRadius(12)
                                            .opacity(0.85)

                                        HStack(spacing: 18) {
                                            AsyncImage(url: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(pokemonResumen.idNumber).png")) { imagen in
                                                imagen
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 60, height: 60)
                                            } placeholder: {
                                                ProgressView()
                                                    .frame(width: 60, height: 60)
                                            }
                                            VStack(alignment: .leading) {
                                                Text("#\(pokemonResumen.idNumber)")
                                                    .font(.caption)
                                                    .foregroundColor(.white)
                                                Text(pokemonResumen.name.capitalized)
                                                    .font(.headline)
                                                    .foregroundColor(.white)
                                            }
                                            Spacer()
                                        }
                                        .padding(.horizontal)
                                    }
                                    .frame(height: 80)
                                    .frame(maxWidth: 400)
                                    .cornerRadius(12)
                                    .shadow(radius: 2)
                                    .padding(.horizontal)
                                    .contentShape(Rectangle()) // Hace toda el área interactiva
                                }
                                .simultaneousGesture(TapGesture().onEnded {
                                    Task {
                                        await controlador.descargar_info_pkm(id: pokemonResumen.idNumber)
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
}
 
#Preview {
    PantallaPokedex()
        .environment(ControladorApi())
}
 
