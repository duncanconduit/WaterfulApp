//
//  PreAuthView.swift
//  Waterful
//
//  Created by Duncan Conduit on 25/06/2023.
//

import SwiftUI

struct PreAuthView: View {
    
    @Binding var showSigninView: Bool
    @StateObject private var viewModel = PreAuthViewModel()
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            
            Spacer()
            
            VStack {
                
                Image("Logo")
                    .resizable()
                    .scaledToFit()
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
                
                if colorScheme == .dark {
                    Button {
                        Task {
                            do {
                                try await viewModel.signInApple()
                                showSigninView = false
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
                                try await viewModel.signInApple()
                                showSigninView = false
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
                            try await viewModel.signInGoogle()
                            showSigninView = false
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
                
                NavigationLink {
                    SignUpEmailView()
                    
                } label: {
                    Text("Get Started")
                        .font(.headline)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .cornerRadius(10)
                }
                .foregroundColor(.white)
                .background(
                    LinearGradient(gradient: Gradient(colors: [.gradPink, .gradPurple]), startPoint: .leading, endPoint: .trailing
                                  ))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .buttonStyle(PlainButtonStyle())
                
                NavigationLink {
                    SignInEmailView(showSignInView: $showSigninView)
                    
                } label: {
                    Text("Sign in to Existing Account")
                        .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
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
        }
        .padding()
        .multilineTextAlignment(.center)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(RadialGradient(gradient: Gradient(colors: [.grad1, .grad2]), center: .center, startRadius: 2, endRadius: 650)
        )
        .ignoresSafeArea()
        
    }
    
    
}

struct PreAuthView_Previews: PreviewProvider {

    static var previews: some View {
        NavigationStack {
            PreAuthView(showSigninView: .constant(false)).preferredColorScheme(.dark)
        }
    }
}
