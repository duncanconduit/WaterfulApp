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
            Image("Logo")
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
            
            
            SignInWithAppleButtonViewRepresentable(type: .continue, style: .black)
            .allowsHitTesting(/*@START_MENU_TOKEN@*/false/*@END_MENU_TOKEN@*/)
            .frame(height: 55)
            .cornerRadius(10)

            NavigationLink {
                AuthSignUpView(showSignInView: $showSignInView)
            
            } label: {
                Text("Continue With Email")
                    .font(.headline)
                    .frame(height: 45)
                    .frame(maxWidth: .infinity)
                    .cornerRadius(10)
            
                
                    }
            .buttonStyle(.borderedProminent)
            
            NavigationLink {
                AuthSignInView(showSignInView: $showSignInView)

            } label: {
                Text("Sign in to Existing Account")
                    .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
                    }
            }
        .padding()
            .multilineTextAlignment(.center)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(RadialGradient(gradient: Gradient(colors: [.grad1, .grad2]), center: .center, startRadius: 2, endRadius: 650)
)
                .ignoresSafeArea()

    }
    
   
}

#Preview {
    NavigationStack {
        PreAuthView(showSignInView: .constant(false))
    }
}
