//
//  PasswordForgetView.swift
//  Waterful
//
//  Created by Duncan Conduit on 25/06/2023.
//

import SwiftUI

var forgotEmail = ""



struct PasswordForgetView: View {
    
    @State private var showResult = false
    
    var body: some View {
        VStack {
            VStack {
                
                Spacer()
                    .frame(minHeight: 10, idealHeight: 30, maxHeight: 600)
                    .fixedSize()
                Text("Forgot Password")
                    .font(Font.largeTitle.weight(.bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
                TextField("" ,text: .constant(forgotEmail), prompt: Text("Email").font(.system(size: 30)))
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .font(.system(size: 30))
                    .minimumScaleFactor(0.1)
                    .padding()
                
                
                Button {
                    showResult.toggle()
                    
                } label: {
                    Text("Send Link")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(height: 55)
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .padding()
                }
                
            }
            Spacer()
            
            Image("dropletPreAuth")
                .resizable()
                .scaledToFit()
                .frame(
                    width: 20,
                    height: 20
                )
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(RadialGradient(gradient: Gradient(colors: [Color("Grad1"), Color("Grad2")]), center: .center, startRadius: 2, endRadius: 650)
        )
        
        
    }
    
}

struct PasswordForgetView_Previews: PreviewProvider {
    static var previews: some View {
        PasswordForgetView()
    }
}
