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
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    pantallaMovimientos()
        .environment(ControladorApi())
}
