//
//  WaterfulApp.swift
//  Waterful
//
//  Created by Duncan Conduit on 25/06/2023.
//  Copyright © 2023 Duncan Conduit. All rights reserved.
//

import SwiftUI

/// The main entry point of the Waterful app.
@main
struct WaterfulApp: App {
  
    /// Initializes the app and updates the user interface style.
    init() {
        updateUserInterfaceStyle()
    }
   
    /// The main body of the app.
    var body: some Scene {
        WindowGroup {
            HomeView()
        }
    }
}
