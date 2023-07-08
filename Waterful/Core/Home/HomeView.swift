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
                Spacer()
                
                HomeViewModel.ShapeElement1()
                    .stroke(.black, style: StrokeStyle(lineWidth: 1, lineCap: .round, lineJoin: .round))
                    .frame(width: 300, height: 500)
                
                Spacer()
                    
                
            }
            .navigationTitle("Home")

    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            HomeView(showSigninView: .constant(true))
        }
    }
}
