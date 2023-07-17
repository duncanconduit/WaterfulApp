//
//  AuthenticationManager.swift
//  Waterful
//
//  Created by Duncan Conduit on 25/06/2023.
//

import Foundation
import FirebaseAuth



struct UserDataModel {
    
    let firstName: String
    let lastName: String
    let DOB: Date
    let onboarded: Bool
    
}


struct AuthDataResultModel {
    let uid: String
    let email: String?
    let photoUrl: String?

    
    init(user: User) {
        self.uid = user.uid
        self.email = user.email
        self.photoUrl = user.photoURL?.absoluteString
    }


}

enum AuthProviderOption: String {
    case email = "password"
    case google = "google.com"
    case apple = "apple.com"
    
}
final class AuthenticationManager {
    
    static let shared = AuthenticationManager()
    private init() { }
    
    func getAuthenticatedUser() throws -> AuthDataResultModel {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        
        return AuthDataResultModel(user: user)
    }
    
    
    func signOut() throws {
        try Auth.auth().signOut()
        
    }
    

    
    func getProvider() throws -> [AuthProviderOption] {
        guard let providerData = Auth.auth().currentUser?.providerData else {
            throw URLError(.badServerResponse)
        }
        var providers: [AuthProviderOption] = []
        for provider in providerData {
            if let option = AuthProviderOption(rawValue: provider.providerID) {
                providers.append(option)
            } else {
                assertionFailure("Provider option not found \(provider.providerID)")
            }
            
        }
        return providers
    }
}


//MARK: SIGN IN EMAIL

extension AuthenticationManager {
    
    @discardableResult
    func createUser(email: String, password: String) async throws  -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
        return AuthDataResultModel(user: authDataResult.user)
        
    }
    
    @discardableResult
    func signInUser(email: String, password: String) async throws  -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().signIn(withEmail: email, password: password)
        return AuthDataResultModel(user: authDataResult.user)
        
    }
}

// MARK: SIGN IN SSO

extension AuthenticationManager {
    
    @discardableResult
    func signInwithGoogle(tokens: GoogleSignInResultModel) async throws -> AuthDataResultModel {
        let credential = GoogleAuthProvider.credential(withIDToken: tokens.idToken,
                                                       accessToken: tokens.accessToken)
        return try await signIn(credential: credential)
    }
    
    @discardableResult
    func signInwithApple(tokens: SignInWithAppleResult) async throws -> AuthDataResultModel {
        let credential = OAuthProvider.credential(withProviderID: AuthProviderOption.apple.rawValue, idToken: tokens.token, rawNonce: tokens.nonce)
        return try await signIn(credential: credential)
    }
    func signIn(credential : AuthCredential) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().signIn(with: credential)
        return AuthDataResultModel(user: authDataResult.user)
    }
    
}
