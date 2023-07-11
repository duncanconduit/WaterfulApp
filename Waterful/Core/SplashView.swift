//
//  SplashView.swift
//  Waterful
//
//  Created by Duncan Conduit on 28/06/2023.
//  Copyright © 2023 Duncan Conduit. All rights reserved.
//



import SwiftUI

struct SplashView: View {
    
    @State var isActive: Bool = false
    @State private var showSignInView: Bool = false
    
    
    var body: some View {
        ZStack {
            if self.isActive {
                if self.showSignInView {
                    NavigationStack {
                        PreAuthView(showSigninView: $showSignInView)
                    }
                }
                else {
                    NavigationStack {
                        MainView(showSigninView: $showSignInView)
                    }
                }
            } else {
                Image("Logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
            }
        }
        .onAppear {
                let authUser = try? AuthenticationManager.shared.getAuthenticatedUser()
                withAnimation {
                    self.showSignInView = authUser == nil
                    self.isActive = true
            }
        }
    }
    
}

struct SplashView_Previews: PreviewProvider {    
    static var previews: some View {
        SplashView()
    }
}

