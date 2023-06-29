//
//  SignInEmailViewModel.swift
//  Waterful
//
//  Created by Duncan Conduit on 30/06/2023.
//

import Foundation

@MainActor
final class SignInEmailViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    
    func signIn() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password")
            return
        }
        
        try await AuthenticationManager.shared.signInUser(email: email, password: password)
    }
    
}
