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
            ScrollView {
                VStack(spacing: 16) {
                    // Título con fondo negro y texto rosa
                    Text("Habilidades")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.pink)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white)
 
                    if let habilidades = controlador.pagina_resultado_hab?.items {
                        ForEach(habilidades) { habilidad in
                            NavigationLink {
                                pantallaHabDet()
                            } label: {
                                HStack {
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(habilidad.name.capitalized)
                                            .font(.headline)
                                            .foregroundColor(.white)
                                        Text("Toca para ver más detalles")
                                            .font(.caption)
                                            .foregroundColor(.pink.opacity(0.8))
                                    }
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.pink)
                                }
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(Color.gray)
                                        .shadow(color: .pink.opacity(0.25), radius: 5, x: 0, y: 3)
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(Color.pink, lineWidth: 1)
                                )
                                .padding(.horizontal)
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
                .background(Color.white)
                .edgesIgnoringSafeArea(.bottom)
            }
            .background(Color.white)
        }
    }
}
 
#Preview {
    pantallaHab()
        .environment(ControladorApi())
}

