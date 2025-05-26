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
            ZStack {
                Image("mov")
                    .resizable()
                    .ignoresSafeArea()
                    .opacity(0.9)
 
                ScrollView {
                    VStack(spacing: 16) {
                        Text("Movimientos")
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(.black))
                            .opacity(0.8)
 
                        if let movimientos = controlador.pagina_resultado_mov?.results {
                            ForEach(movimientos) { movimiento in
                                NavigationLink {
                                    pantallaMovDet()
                                } label: {
                                    ZStack {
                                        Image("item")
                                            .resizable()
                                            .frame(height: 80)
                                            .cornerRadius(12)
                                            .opacity(0.9)
 
                                        HStack(spacing: 17) {
                                            VStack {
                                                Rectangle()
                                                    .frame(width: 66)
                                                    .opacity(0)
                                            }
 
                                            VStack(alignment: .leading, spacing: 4) {
                                                Text(movimiento.name.capitalized)
                                                    .font(.headline)
                                                    .foregroundColor(.white)
 
                                                Text("Toque para ver más detalles")
                                                    .font(.caption)
                                                    .foregroundColor(.gray)
                                            }
 
                                            Spacer()
 
                                            Image(systemName: "chevron.right")
                                                .foregroundColor(.purple)
                                        }
                                        .padding()
                                    }
                                    .padding(.horizontal)
                                    .contentShape(Rectangle())
                                }
                                .simultaneousGesture(TapGesture().onEnded {
                                    Task {
                                        await controlador.seleccionar_mov(movimiento)
                                    }
                                })
                            }
                        } else {
                            ProgressView("Cargando movimientos…")
                                .padding()
                                .task {
                                    await controlador.descargar_movimientos()
                                }
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
