//
//  pantalla_movimientos.swift
//  Pokedex
//
//  Created by alumno on 21/5/25.
//

import SwiftUI
 
struct pantallaMovimientos: View {
    @Environment(ControladorApi.self) var controlador
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 12) {
                    Text("Movimientos")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.black)
                        .padding(.top)
                    if let movimientos = controlador.pagina_resultado_mov?.results {
                        ForEach(movimientos) { movimiento in
                            NavigationLink {
                                // Aquí iría pantallaMovDetalle si la implementas
                                Text("Detalles de \(movimiento.name.capitalized)")
                            } label: {
                                HStack {
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(movimiento.name.capitalized)
                                            .font(.headline)
                                            .foregroundColor(.black)
                                        Text("Ver mas detalles de \(movimiento.name)")
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                    }
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.pink)
                                }
                                .padding()
                                .background(Color(.systemGray6))
                                .cornerRadius(12)
                                .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 1)
                            }
                            .padding(.horizontal)
                        }
                    } else {
                        ProgressView("Cargando movimientos...")
                            .padding()
                            .task {
                                await controlador.descargar_movimientos()
                            }
                    }
                }
            }
            .background(Color.white)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    pantallaMovimientos()
        .environment(ControladorApi())
}
