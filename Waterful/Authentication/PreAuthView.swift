//
//  PreAuthVIew.swift
//  Waterful
//
//  Created by Duncan Conduit on 25/06/2023.
//

import SwiftUI

struct PreAuthView: View {
    
    @Binding var showSignInView: Bool
    
    var body: some View {
        VStack {
            Image("Placeholder")
                .resizable(resizingMode: .stretch)
                .frame(
                    width: 80,
                    height: 80,
                    alignment: .center
                    )

            Text("Welcome to Waterful")
                .font(.system(.largeTitle, design: .default))
                .bold()

            Text("Build Healthy Habits")
                .foregroundColor(Color(uiColor: .secondaryLabel))

            Spacer()
            .frame(
                height: 32,
                alignment: .center
                )

            NavigationLink {
                AuthSignUpView(showSignInView: $showSignInView)

            } label: {
                Text("Get Started")
                    .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
                
                    }
            .buttonStyle(.borderedProminent)
            
            NavigationLink {
                AuthSignInView(showSignInView: $showSignInView)

            } label: {
                Text("Sign in to Existing Account")
                    .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
                    }
            }
            .multilineTextAlignment(.center)

    }
   
}

#Preview {
    NavigationStack {
        PreAuthView(showSignInView: .constant(false))
    }
}
