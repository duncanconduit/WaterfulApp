//
//  PreAuthViewModel.swift
//  Waterful
//
//  Created by Duncan Conduit on 30/06/2023.
//

import Foundation
import SwiftUI
import UIKit
import AuthenticationServices



@MainActor
final class PreAuthViewModel: NSObject, ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    @Published var firstName = ""
    @Published var lastName = ""

    
    
    func signInGoogle() async throws {
        let helper = SignInWithGoogleHelper()
        let tokens = try await helper.signIn()
        let authDataResult = try await AuthenticationManager.shared.signInwithGoogle(tokens: tokens)
    }
    
    func signInApple() async throws {
        let helper = SignInWithAppleHelper()
        let tokens = try await helper.startSignInWithAppleFlow()
        let authDataResult = try await AuthenticationManager.shared.signInwithApple(tokens: tokens)
        let data = UserDataModel(firstName: firstName, lastName: lastName, DOB: Date(),onboarded: true)
        let user = DBUser(auth: authDataResult,data: data)
        try await UserManager.shared.createNewUser(user: user)
    }
    
    
}
