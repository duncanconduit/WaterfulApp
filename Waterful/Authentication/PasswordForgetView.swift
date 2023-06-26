//
//  PasswordForgetView.swift
//  Waterful
//
//  Created by Duncan Conduit on 25/06/2023.
//

import SwiftUI

var email = ""

struct PasswordForgetView: View {
    var body: some View {
        VStack {
            TextField("Email....", text: .constant(email))
                .padding()
                .background(Color.gray.opacity(0.4))
                .cornerRadius(10)
            
            Button {
                
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
        .padding()
    }
}

#Preview {
    PasswordForgetView()
}
