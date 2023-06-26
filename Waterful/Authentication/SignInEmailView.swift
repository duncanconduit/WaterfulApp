//
//  SignInEmailView.swift
//  Waterful
//
//  Created by Duncan Conduit on 26/06/2023.
//

import SwiftUI

struct SignInEmailView: View {
    
    @StateObject private var viewModel = SignInEmailViewModel()
    @Binding var showSignInView: Bool
    

    @State private var showDetails = false
    @State private var showButton = true
    
    var body: some View {
        VStack {
            VStack {
                Spacer()
                    .frame(minHeight: 10, idealHeight: 30, maxHeight: 600)
                    .fixedSize()
                Text("Sign in")
                    .font(Font.title.weight(.bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
                HStack {
                    TextField("" ,text: $viewModel.email, prompt: Text("Email").font(.headline))
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.never)
                        .font(.system(size: 30))
                        .minimumScaleFactor(0.1)
                        .padding()
                    
                    if showButton {
                        Button {
                            withAnimation {
                                showDetails.toggle()
                                showButton.toggle()
                            }
                        } label: {
                            Image(systemName: "arrowshape.right.fill")
                                .font(.system(size: 30))
                        }
                        .padding()
                        
                    }
                }
                
                if showDetails {
                    VStack {
                    HStack {
                        SecureField("" ,text: $viewModel.password, prompt: Text("Password").font(.headline))
                            .textInputAutocapitalization(.never)
                            .font(.system(size: 30))
                            .minimumScaleFactor(0.1)
                            .padding()
                        
                        Button {
                            Task {
                                do {
                                    try await viewModel.signIn()
                                    showSignInView = false
                                } catch {
                                    print(error)
                                }
                            }
                        } label: {
                            Image(systemName: "arrowshape.right.fill")
                                .font(.system(size: 30))
                        }
                        .padding()
                        }
                        NavigationLink {
                            PasswordForgetView()
                            
                        } label: {
                            Text("Forgot Password")
                                .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
                        }
                        
                        
                    }
                }
                
            }
        Spacer()
            
        Image("droplet")
                .resizable()
                .scaledToFit()
                .frame(
                    width: 20,
                    height: 20,
                    alignment: .bottom
                    )
                .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(RadialGradient(gradient: Gradient(colors: [.grad2, .grad1]), center: .center, startRadius: 100, endRadius: 650)
            )
    }
}

#Preview {
    NavigationStack {
        SignInEmailView(showSignInView: .constant(false))
    }
}
