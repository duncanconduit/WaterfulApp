//
//  UpFlowEmailView.swift
//  Waterful
//
//  Created by Duncan Conduit on 26/06/2023.
//

import SwiftUI



struct SignUpEmailView: View {
    
    @Binding var showSignInView: Bool
    @State private var showDetails = false
    @State private var showButton = true
    @State private var showEmail = false
    @State private var showPassword = false
    @State private var isSecured = true
    @State private var showCPassword = false
    @StateObject private var viewModel = SignUpEmailViewModel()

    
    
    var body: some View {
        VStack {
            VStack {
                
                
                if showButton {
                    
                    Spacer()
                        .frame(minHeight: 30, idealHeight: 40, maxHeight: 600)
                        .fixedSize()
                    Text("Welcome,\nWhat's Your Name?")
                        .font(Font.largeTitle.weight(.bold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                    
                    Spacer()
                        .frame(minHeight: 10, idealHeight: 120, maxHeight: 600)
                        .fixedSize()
                    
                    
                    TextField("" ,text: $viewModel.firstName, prompt: Text("First Name").font(Font.title.weight(.semibold)))
                        .textContentType(.givenName)
                        .font(.largeTitle)
                        .minimumScaleFactor(0.1)
                        .padding()
                    
                    
                    
                    Button {
                       withAnimation {
                           showButton.toggle()
                           showDetails.toggle()
                       }
                   } label: {
                       Image(systemName: "arrowshape.right.fill")
                           .font(.system(size: 40))
                   }
                   .tint(
                       LinearGradient(gradient: Gradient(colors: [Color("GradPink"), Color("GradPurple")]), startPoint: .leading, endPoint: .trailing
                                     ))
                   
                    .padding()
                }
                
                if showDetails {
                    VStack {
                        
                        Spacer()
                            .frame(minHeight: 10, idealHeight: 30, maxHeight: 600)
                            .fixedSize()
                        VStack {
                            Image(systemName: "hand.wave")
                                .font(Font.largeTitle.weight(.bold))
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            
                            Text("Hi, \(viewModel.firstName)\nWhat's Your Last Name?")
                                .font(Font.largeTitle.weight(.bold))
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                        }
                        .padding()
                        
                        Spacer()
                            .frame(minHeight: 10, idealHeight: 60, maxHeight: 600)
                            .fixedSize()
                        
                        
                        TextField("" ,text: $viewModel.lastName, prompt: Text("Last Name").font(.title))
                            .textContentType(.familyName)
                            .font(.largeTitle)
                            .minimumScaleFactor(0.1)
                            .padding()
                        
                        Button {
                            print("button pressed")
                            showEmail.toggle()
                            showDetails.toggle()
                        } label: {
                            Image(systemName: "arrowshape.right.fill")
                                .font(.system(size: 40))
                        }
                        .tint(
                            LinearGradient(gradient: Gradient(colors: [Color("GradPink"), Color("GradPurple")]), startPoint: .leading, endPoint: .trailing
                                          ))
                        .padding()
                        
                        
                        Spacer()
                        
                        
                    }
                }
                    if showEmail {
                        VStack {
                            
                            Spacer()
                                .frame(minHeight: 10, idealHeight: 30, maxHeight: 600)
                                .fixedSize()
                            VStack {
                                Image(systemName: "hand.wave")
                                    .font(Font.largeTitle.weight(.bold))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                
                                Text("Hi, \(viewModel.firstName)\nWhat's Your Email?")
                                    .font(Font.largeTitle.weight(.bold))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                            }
                            .padding()
                            
                            Spacer()
                                .frame(minHeight: 10, idealHeight: 60, maxHeight: 600)
                                .fixedSize()
                            
                            
                                
                                TextField("" ,text: $viewModel.email, prompt: Text("Email").font(.title))
                                    .keyboardType(.emailAddress)
                                    .textInputAutocapitalization(.never)
                                    .font(.largeTitle)
                                    .minimumScaleFactor(0.1)
                                    .padding()
                                
                            
                            
                            Button {
                                showEmail.toggle()
                                showPassword.toggle()
                            } label: {
                                Image(systemName: "arrowshape.right.fill")
                                    .font(.system(size: 40))
                            }
                            .tint(
                                LinearGradient(gradient: Gradient(colors: [Color("GradPink"), Color("GradPurple")]), startPoint: .leading, endPoint: .trailing
                                              ))
                            .padding()
                            
                            
                            Spacer()
                            
                            
                        }
                    }
                
               if showPassword {
                   VStack {
                       
                       Spacer()
                           .frame(minHeight: 10, idealHeight: 30, maxHeight: 600)
                           .fixedSize()
                       VStack {
                           
                           Text("\nEnter Your Password")
                               .font(Font.largeTitle.weight(.bold))
                               .frame(maxWidth: .infinity, alignment: .leading)
                           
                       }
                       .padding()
                       
                       Spacer()
                           .frame(minHeight: 10, idealHeight: 60, maxHeight: 600)
                           .fixedSize()
                       
                       
                       
                       SecureField("" ,text: $viewModel.password, prompt: Text("Password").font(.title))
                           .textInputAutocapitalization(.never)
                           .textContentType(.newPassword)
                           .font(.largeTitle)
                           .minimumScaleFactor(0.1)
                           .padding()
                       
                       if showCPassword {
                           
                           SecureField("" ,text: $viewModel.cpassword, prompt: Text("Confirm Password").font(.title))
                               .textInputAutocapitalization(.never)
                               .textContentType(.password)
                               .font(.largeTitle)
                               .minimumScaleFactor(0.1)
                               .padding()
                           
                           
                       }
                      
                       if showCPassword == false {
                           Button {
                               withAnimation {
                                   showCPassword.toggle()
                               }
                           } label: {
                               Image(systemName: "arrowshape.right.fill")
                                   .font(.system(size: 40))
                           }
                           
                           .tint(
                            LinearGradient(gradient: Gradient(colors: [Color("GradPink"), Color("GradPurple")]), startPoint: .leading, endPoint: .trailing
                                          ))
                           .padding()
                       }
                       
                       if showCPassword {
                           
                           Button {
                               Task {
                                   do {
                                       try await viewModel.signUp()
                                       showSignInView = false
                                   } catch {
                                       print(error)
                                       }
                                   }
                           } label: {
                               Image(systemName: "arrowshape.right.fill")
                                   .font(.system(size: 40))
                           }
                           
                           .tint(
                            LinearGradient(gradient: Gradient(colors: [Color("GradPink"), Color("GradPurple")]), startPoint: .leading, endPoint: .trailing
                                          ))
                           .padding()
                           .disabled(viewModel.password != viewModel.cpassword)
                           
                       }
                        
                       
                       
                        
                        Spacer()
                        
                        
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
                    alignment: .center
                )
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(RadialGradient(gradient: Gradient(colors: [Color("Grad1"), Color("Grad2")]), center: .center, startRadius: 2, endRadius: 650)
        )
    }
}

struct SignUpEmailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SignUpEmailView(showSignInView: .constant(true))
        }
    }
}

