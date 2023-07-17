//
//  SignInEmailView.swift
//  Waterful
//
//  Created by Duncan Conduit on 26/06/2023.
//

import SwiftUI





struct SignInEmailView: View {
    

    
    let authFeedback = UINotificationFeedbackGenerator()
    
    init(showSignInView: Binding<Bool>) {
           authFeedback.prepare()
            self._showSignInView = showSignInView
       }
    
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
                                SignInWithAppleButtonViewRepresentable(type: .signIn, style: .white)
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
                                SignInWithAppleButtonViewRepresentable(type: .signIn, style: .black)
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
                                Text("Sign in with Google")
                                    .font(.system(size: 20))
                                    .fontWeight(.semibold)
                                    .foregroundStyle(Color("GoogleFont"))
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
                        .tint(Color("GoogleGray"))
                    }
                    .padding()
                }
                HStack {
                    TextField("" ,text: $viewModel.email, prompt: Text("Email").font(.system(size: 30)))
                        .textContentType(.username)
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
                            .textContentType(.password)
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
                                        authFeedback.notificationOccurred(.error)
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
            .background(RadialGradient(gradient: Gradient(colors: [Color("Grad1"), Color("Grad2")]), center: .center, startRadius: 2, endRadius: 650)
            )
        }
    }
}

struct SignInEmailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SignInEmailView(showSignInView: .constant(true))
        }
    }
}

