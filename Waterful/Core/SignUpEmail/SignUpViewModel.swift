//
//  SignUpViewModel.swift
//  Waterful
//
//  Created by Duncan Conduit on 15/07/2023.
//  Copyright © 2023 Duncan Conduit. All rights reserved.
//

import Foundation

import Foundation

@MainActor
final class SignUpEmailViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    @Published var firstName = ""
    @Published var lastName = ""
    @Published var cpassword = ""

    
    func signUp() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password")
            return
        }
        
        let authDataResult = try await AuthenticationManager.shared.createUser(email: email, password: password)
        let data = UserDataModel(firstName: firstName, lastName: lastName, DOB: Date(),onboarded: true)
        let user = DBUser(auth: authDataResult,data: data)
        try await UserManager.shared.createNewUser(user: user)
    }
    
    
}
