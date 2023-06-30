//
//  UpFlowEmailView.swift
//  Waterful
//
//  Created by Duncan Conduit on 26/06/2023.
//

import SwiftUI



struct SignUpEmailView: View {
    
    
    @State private var email = ""
    @State private var password = ""
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var showDetails = false
    @State private var showButton = true
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
                    
                    
                    TextField("" ,text: $firstName, prompt: Text("First Name").font(Font.title.weight(.semibold)))
                        .font(.largeTitle)
                        .minimumScaleFactor(0.1)
                        .padding()
                    
                    Button {
                        print("button pressed")
                        withAnimation {
                            showButton.toggle()
                            showDetails.toggle()
                        }
                    } label: {
                        Image(systemName: "arrowshape.right.fill")
                            .font(.system(size: 40))
                    }
                    .tint(
                        LinearGradient(gradient: Gradient(colors: [.gradPink, .gradPurple]), startPoint: .leading, endPoint: .trailing
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
                            
                            
                            Text("Hi, \(firstName)\nWhat's Your Last Name?")
                                .font(Font.largeTitle.weight(.bold))
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                        }
                        .padding()
                        
                        Spacer()
                            .frame(minHeight: 10, idealHeight: 60, maxHeight: 600)
                            .fixedSize()
                        
                        
                        TextField("" ,text: $password, prompt: Text("Last Name").font(.title))
                            .font(.largeTitle)
                        
                            .minimumScaleFactor(0.1)
                            .padding()
                        
                        Button {
                            print("button pressed")
                        } label: {
                            Image(systemName: "arrowshape.right.fill")
                                .font(.system(size: 40))
                        }
                        .tint(
                            LinearGradient(gradient: Gradient(colors: [.gradPink, .gradPurple]), startPoint: .leading, endPoint: .trailing
                                          ))
                        .padding()
                        
                        
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
        .background(RadialGradient(gradient: Gradient(colors: [.grad1, .grad2]), center: .center, startRadius: 2, endRadius: 650)
        )
    }
}

struct SignUpEmailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SignUpEmailView()
        }
    }
}
