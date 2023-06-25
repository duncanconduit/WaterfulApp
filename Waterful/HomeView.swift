//
//  HomeView.swift
//  Waterful
//
//  Created by Duncan Conduit on 25/06/2023.
//

import SwiftUI

@MainActor
final class SettingsViewModel: ObservableObject {
    
    func signOut() throws {
       try AuthenticationManager.shared.signOut()
    }
}

struct HomeView: View {
    
    @StateObject private var viewModel = SettingsViewModel()
    @Binding var showSigninView: Bool
    
    var body: some View {
        VStack {
            Text("Home Page")
            
            
            Button("Sign Out") {
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
        .navigationTitle(Text(Date.now, format: .dateTime.day().month().year()))
    }
    
}

#Preview {
    NavigationStack {
        HomeView(showSigninView: .constant(true))
    }
}
