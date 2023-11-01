//
//  WaterfulApp.swift
//  Waterful
//
//  Created by Duncan Conduit on 25/06/2023.
//

import SwiftUI
import SwiftData

@main
struct WaterfulApp: App {
    
    @State var selectedAppearance: SettingsViewModel.Appearance = .system
    
    let container: ModelContainer = {
        
        let schema = Schema([WaterIntake.self])
        let container =  try! ModelContainer(for: schema, configurations: [])
        return container
    }()
    
    var body: some Scene {
        WindowGroup {
            HomeView(selectedAppearance: $selectedAppearance)
            .preferredColorScheme(selectedAppearance.tag == 0 ? .light : selectedAppearance.tag == 1 ? .dark : nil)
           
        }
        .modelContainer(container)
    }
}
