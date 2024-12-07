//
//  Session05App.swift
//  Session05
//
//  Created by DAMII on 3/12/24.
//

import SwiftUI

@main
struct Session05App: App {
    let persistence = PersistenceController.shared
   
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(
                    \.managedObjectContext,
                     persistence.container.viewContext
                )
        }
    }
}
