//
//  HomeView.swift
//  Waterful
//
//  Created by Duncan Conduit on 25/06/2023.
//

import SwiftUI


struct HomeView: View {
    
    @StateObject private var viewModel = HomeViewModel()
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

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            HomeView(showSigninView: .constant(true))
        }
    }
}
