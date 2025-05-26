//
//  pantalla_hab.swift
//  Pokedex
//
//  Created by alumno on 19/5/25.
//

import SwiftUI
 
struct pantallaHab: View {
    @Environment(ControladorApi.self) var controlador
 
    var body: some View {
        NavigationStack {
            ZStack {
                Image("hab")
                    .resizable()
                    .ignoresSafeArea()
                    .opacity(0.9)
 
                ScrollView {
                    VStack(spacing: 16) {
                        // Título
                        Text("Habilidades")
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(.black))
                            .opacity(0.89)
 
                        if let habilidades = controlador.pagina_resultado_hab?.items {
                            ForEach(habilidades) { habilidad in
                                NavigationLink {
                                    pantallaHabDet()
                                } label: {
                                    ZStack {
                                        Image("item")
                                            .resizable()
                                            .frame(height: 80)
                                            .cornerRadius(12)
                                            .opacity(0.9)
                                        
 
                                        HStack(spacing: 16) {
                                            VStack{
                                                
                                            }
                                            .frame(width: 55)
                                            VStack(alignment: .leading, spacing: 4) {
                                                Text(habilidad.name.capitalized)
                                                    .font(.headline)
                                                    .foregroundColor(.white)
                                                Text("Toca para ver más detalles")
                                                    .font(.caption)
                                                    .foregroundColor(.white.opacity(0.8))
                                            }
                                            Spacer()
                                            Image(systemName: "chevron.right")
                                                .foregroundColor(.yellow)
                                        }
                                        .padding(.horizontal)
                                    }
                                    .padding(.horizontal)
                                    .shadow(radius: 1)
                                }
                                .simultaneousGesture(TapGesture().onEnded {
                                    Task {
                                        await controlador.seleccionar_hab(habilidad)
                                    }
                                })
                            }
                        } else {
                            ProgressView("Cargando habilidades...")
                                .padding()
                                .task {
                                    await controlador.descargar_habilidades()
                                }
                        }
                    }
                    .padding(.bottom)
                }
            }
        }
    }
}
 
#Preview {
    pantallaHab()
        .environment(ControladorApi())
}

