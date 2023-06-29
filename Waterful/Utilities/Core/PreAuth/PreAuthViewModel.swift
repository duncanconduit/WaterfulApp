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



struct SignInWithAppleButtonViewRepresentable: UIViewRepresentable {
    
    let type: ASAuthorizationAppleIDButton.ButtonType
    let style: ASAuthorizationAppleIDButton.Style
    
    func makeUIView(context: Context) -> ASAuthorizationAppleIDButton {
        ASAuthorizationAppleIDButton(authorizationButtonType: type, authorizationButtonStyle: style)
    }
    
    func updateUIView(_ uiView: ASAuthorizationAppleIDButton, context: Context) {
        
    }
}


@MainActor
final class PreAuthViewModel: NSObject, ObservableObject {
    
    @Published var didSignInWithApple: Bool = false
    
    
    func signInGoogle() async throws {
        let helper = SignInWithGoogleHelper()
        let tokens = try await helper.signIn()
        try await AuthenticationManager.shared.signInwithGoogle(tokens: tokens)
    }
    
    func signInApple() async throws {
        let tokens = try await SignInWithAppleHelper.shared.startSignInWithAppleFlow()
        try await AuthenticationManager.shared.signInwithApple(tokens: tokens)
        
    }
    
    
}
