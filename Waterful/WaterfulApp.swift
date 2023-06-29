//
//  WaterfulApp.swift
//  Waterful
//
//  Created by Duncan Conduit on 25/06/2023.
//

import SwiftUI
import Firebase

@main
struct WaterfulApp: App {
    
    init() {
        FirebaseApp.configure()
        print("Configured Firebase")
    }
    var body: some Scene {
        WindowGroup {
            SplashView()

        }
    }
}
