//
//  menu_nav.swift
//  Pokedex
//
//  Created by alumno on 26/5/25.
//

import SwiftUI

struct MenuNav: View{
    @Environment(ControladorApi.self) var controlador
    var body: some View{
        TabView{
            PantallaPokedex()
                .tabItem { Label("Pokedex", systemImage: "pawprint.fill")
                }
              //  .badge(controlador.pokemon_seleccionado.count)
            
            pantallaHab()
                .tabItem {Label("Habilidades", systemImage : "brain.fill")
                    }
            
            pantallaMovimientos()
                .tabItem { Label("Movimientos", systemImage: "moon.stars")
                }
        }
    }
}

#Preview {
    MenuNav()
        .environment(ControladorApi())
}
