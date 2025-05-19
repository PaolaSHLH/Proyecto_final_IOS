//
//  pantalla_hab.swift
//  Pokedex
//
//  Created by alumno on 19/5/25.
//

import SwiftUI

struct pantallaHab: View {
    @Environment (ControladorApi.self) var controlador
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 12) {
                    Text("Habilidades")
                        .font(.largeTitle).bold()
                        .padding(.top)
                    
                    if let habilidades = controlador.pagina_resultado_hab?.items {
                        ForEach(habilidades) { habilidad in
                            NavigationLink {
                                //HabilidadDetalleView(habilidadResumen: habilidad)
                            } label: {
                                Text(habilidad.name.capitalized)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding()
                                    .background(Color(.systemGray5))
                                    .cornerRadius(8)
                                    .padding(.horizontal)
                            }
                            .simultaneousGesture(TapGesture().onEnded {
                                //controlador.seleccionar_habilidad(habilidad)
                            })
                        }
                    } else {
                        ProgressView("Cargando habilidades...")
                            .task {
                                await controlador.descargar_habilidades()
                            }
                    }
                }
            }
        }
    }
}

#Preview {
    pantallaHab()
        .environment(ControladorApi())
}
