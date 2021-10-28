//
//  SpacelyApp.swift
//  Spacely
//
//  Created by Mikolaj Zawada on 17/10/2021.
//

import SwiftUI

@main
struct SpacelyApp: App {
    
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
