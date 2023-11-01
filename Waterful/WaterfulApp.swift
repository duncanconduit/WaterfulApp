//
//  WaterfulApp.swift
//  Waterful
//
//  Created by Duncan Conduit on 25/06/2023.
//

import SwiftUI


@main
struct WaterfulApp: App {
  
  
    init() {
        updateUserInterfaceStyle()
    }
   
  
    
    var body: some Scene {
        WindowGroup {
            
            HomeView()
            
            
            
        }
        
    }
   

}
