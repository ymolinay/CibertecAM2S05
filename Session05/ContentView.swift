//
//  ContentView.swift
//  Session05
//
//  Created by DAMII on 3/12/24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Usuario.nombre, ascending: true)],
        animation: .default
    ) private var usuarios: FetchedResults<Usuario>
    
    @State private var contador: Int = 1
    @State private var isLoading: Bool = false
    
    var body: some View {
        VStack {
            
            Button(action: {
                Task {
                    await agregarUsuario()
                }
            }) {
                if isLoading {
                    ProgressView()
                } else {
                    Text("Agregar usuario")
                        .padding()
                        .background(.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            
            List {
                ForEach(usuarios) { item in
                    VStack(alignment: .leading) {
                        Text(item.nombre ?? "Sin nombre")
                            .font(.headline)
                        Text(item.correo ?? "Sin correo")
                            .font(.headline)
                            .foregroundColor(.gray)
                    }
                }
            }
            
        }
    }
    
    private func agregarUsuario() async {
        isLoading = true
            
        //Thread.sleep(forTimeInterval: 3)
        //await Task.sleep(3_000_000_000)
        await viewContext.perform {
            withAnimation {
                let nuevoUsuario = Usuario(context: viewContext)
                nuevoUsuario.id = UUID()
                nuevoUsuario.nombre =
                    "Usuario \( String(format: "%02d", contador) )"
                nuevoUsuario.correo =
                    "correo\( String(format: "%02d", contador) )@yopmail.com"
                
                do {
                    try viewContext.save()
                    contador += 1
                } catch {
                    print("Error al guardar: \(error.localizedDescription)")
                }
            }
            isLoading = false
        }
        
    }
}
