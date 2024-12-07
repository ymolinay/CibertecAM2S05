//
//  Persistence.swift
//  Session05
//
//  Created by DAMII on 3/12/24.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "Session05")
        container.loadPersistentStores {_, error in
            if let error = error as NSError? {
                fatalError("Ocurrió un error \(error)")
            }
        }
    }
}
