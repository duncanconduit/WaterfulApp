//
//  PasswordForgetView.swift
//  Waterful
//
//  Created by Duncan Conduit on 25/06/2023.
//

import SwiftUI

var email = ""

struct PasswordForgetView: View {
    
    @State private var showResult = false
    
    var body: some View {
    VStack {
        VStack {
            TextField("Email....", text: .constant(email))
                .padding()
                .background(Color.gray.opacity(0.4))
                .cornerRadius(10)
            
            
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

        
    }
}

#Preview {
    PasswordForgetView()
}
