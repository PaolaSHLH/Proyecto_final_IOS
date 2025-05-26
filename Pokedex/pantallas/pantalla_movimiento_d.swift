import SwiftUI
 
struct pantallaMovDet: View {
    @Environment(ControladorApi.self) var controlador
 
    var body: some View {
        if let mov = controlador.mov_seleccionado {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    // Tarjeta de nombre del movimiento
                    ZStack {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(
                                LinearGradient(
                                    gradient: Gradient(colors: [Color.gray.opacity(0.8), Color.white.opacity(0.8)]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .frame(maxWidth: .infinity, minHeight: 100)
                            .shadow(radius: 4)
                        Text(mov.name.capitalized)
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(.primary)
                    }
 
                    // Contenedor de información
                    VStack(alignment: .leading, spacing: 12) {
                        // Tipo y clase
                        HStack(spacing: 16) {
                            Label("Tipo:", systemImage: "flame.fill")
                            Text(mov.type.name.capitalized)
                                .bold()
                                .foregroundColor(.black)
                            Spacer()
                            Label("Clase:", systemImage: "target")
                            Text(mov.damage_class.name.capitalized)
                                .bold()
                                .foregroundColor(.black)
                        }
                        Divider()
 
                        // Estadísticas
                        VStack(alignment: .leading, spacing: 6) {
                            Text("📊 Estadísticas:")
                                .font(.title3)
                                .bold()
                            HStack {
                                Text("Poder: \(mov.power ?? 0)")
                                Spacer()
                                Text("Precisión: \(mov.accuracy ?? 0)%")
                                Spacer()
                                Text("PP: \(mov.pp ?? 0)")
                            }
                            .font(.subheadline)
                        }
                        Divider()
 
                        // Efecto
                        if let efecto = mov.effect_entries.first(where: { $0.language.name == "es" }) {
                            Text("🌀 Efecto:")
                                .font(.title3)
                                .bold()
                            Text(efecto.short_effect)
                                .font(.body)
                                .foregroundColor(.primary)
                        } else if let efecto = mov.effect_entries.first(where: { $0.language.name == "en" }) {
                            Text("🌀 Effect:")
                                .font(.title3)
                                .bold()
                            Text(efecto.short_effect)
                                .font(.body)
                                .foregroundColor(.primary)
                        }
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color(.systemGray6))
                            .shadow(radius: 1)
                    )
                }
                .padding()
            }
            .background(Color.purple)
        } else {
            ProgressView("Cargando movimiento...")
                .navigationTitle("Movimiento")
        }
    }
}
 
#Preview {
    pantallaMovDet()
        .environment(ControladorApi())
}
