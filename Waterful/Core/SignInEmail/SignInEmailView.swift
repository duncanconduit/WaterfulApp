//
//  SignInEmailView.swift
//  Waterful
//
//  Created by Duncan Conduit on 26/06/2023.
//

import SwiftUI


struct SignInEmailView: View {
    
    @State private var isActive = false
    @StateObject private var viewModel = SignInEmailViewModel()
    @StateObject private var authViewModel = PreAuthViewModel()
    @Binding var showSignInView: Bool
    @Environment(\.colorScheme) var colorScheme
    
    @State private var showPassword = false
    @State private var showButton = true
    @State private var showIncorrect = false
    
    var body: some View {
        VStack {
            VStack {
                Spacer()
                    .frame(minHeight: 10, idealHeight: 30, maxHeight: 600)
                    .fixedSize()
                Text("Sign in")
                    .font(Font.largeTitle.weight(.bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
                if showButton {
                    VStack {
                        if colorScheme == .dark {
                            Button {
                                Task {
                                    do {
                                        try await authViewModel.signInApple()
                                        showSignInView = false
                                    } catch {
                                        print(error)
                                    }
                                }
                            } label: {
                                SignInWithAppleButtonViewRepresentable(type: .continue, style: .white)
                                    .allowsHitTesting(true)
                                    .frame(height: 55)
                                    .cornerRadius(10)
                            }
                        }
                        else {
                            Button {
                                Task {
                                    do {
                                        try await authViewModel.signInApple()
                                        showSignInView = false
                                    } catch {
                                        print(error)
                                    }
                                }
                            } label: {
                                SignInWithAppleButtonViewRepresentable(type: .continue, style: .black)
                                    .allowsHitTesting(true)
                                    .frame(height: 55)
                                    .cornerRadius(10)
                            }
                        }
                        
                        Button {
                            Task {
                                do {
                                    try await authViewModel.signInGoogle()
                                    showSignInView = false
                                } catch {
                                    print(error)
                                }
                            }
                        } label: {
                            Label {
                                Text("Continue with Google")
                                    .font(.system(size: 20))
                                    .fontWeight(.semibold)
                                    .foregroundStyle(Color.googleFont)
                            } icon: {
                                Image("GoogleLogo")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 21, height: 50 )
                            }
                            .frame(height: 45)
                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                            
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(Color.googleGray)
                    }
                    .padding()
                }
                HStack {
                    TextField("" ,text: $viewModel.email, prompt: Text("Email").font(.system(size: 30)))
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.never)
                        .font(.system(size: 30))
                        .minimumScaleFactor(0.1)
                        .padding()
                    
                    if showButton {
                        Button {
                            withAnimation {
                                showPassword.toggle()
                                showButton.toggle()
                            }
                        } label: {
                            Image(systemName: "arrowshape.right.fill")
                                .font(.system(size: 30))
                                .padding()
                        }
                        
                    }
                }
                if showPassword {
                    HStack {
                        SecureField("" ,text: $viewModel.password, prompt: Text("Password").font(.system(size: 30)))
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
                                    withAnimation {
                                        showIncorrect = true
                                    }
                                }
                            }
                            
                        } label: {
                            Image(systemName: "arrowshape.right.fill")
                                .font(.system(size: 30))
                        }
                        .padding()
                    }
                    if showIncorrect {
                        Text("Incorrect email or password")
                            .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
                            .foregroundColor(.red)
                    }
                    NavigationLink(destination: PasswordForgetView(), isActive: $isActive) {
                        Button {
                            forgotEmail = viewModel.email
                            isActive = true
                        } label: {
                            Text("Forgot Password")
                                .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
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
            .background(RadialGradient(gradient: Gradient(colors: [.grad1, .grad2]), center: .center, startRadius: 2, endRadius: 650)
            )
        }
    }
}

#Preview {
    NavigationStack {
        SignInEmailView(showSignInView: .constant(false))
    }
}

