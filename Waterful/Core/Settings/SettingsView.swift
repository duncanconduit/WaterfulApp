//
//  SettingsView.swift
//  Waterful
//
//  Created by Duncan Conduit on 06/07/2023.
//  Copyright © 2023 Duncan Conduit. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    
    
    @StateObject private var viewModel = SettingsViewModel()
    @Binding var showSigninView: Bool

    var body: some View {
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            
            Button("Sign Out "){
                Task {
                    do {
                        try viewModel.signOut()
                        showSigninView = true
                    } catch {
                        print(error)
                    }
                }
            }
        }
        .navigationTitle("Settings")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(showSigninView: .constant(true))
    }
}
