//
//  MainView.swift
//  Waterful
//
//  Created by Duncan Conduit on 06/07/2023.
//  Copyright © 2023 Duncan Conduit. All rights reserved.
//

import SwiftUI




struct MainView: View {
    
    @State var selection = 1
    @Binding var showSigninView: Bool
    
    var body: some View {
            
            TabView(selection: $selection) {
                NavigationView {
                    HomeView(showSigninView: $showSigninView)
                    }
                    .tabItem {
                        Label("Home", systemImage: "house")
                    } .tag(1)
                
                NavigationView {
                    SettingsView(showSigninView: $showSigninView)
                }
                    .tabItem {
                        Label("Settings", systemImage: "gear")
                    } .tag(2)
                    
            }
    
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(showSigninView: .constant(true))
    }
}
