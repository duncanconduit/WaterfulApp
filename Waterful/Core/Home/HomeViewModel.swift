//
//  HomeViewModel.swift
//  Waterful
//
//  Created by Duncan Conduit on 30/06/2023.
//

import Foundation


@MainActor
final class HomeViewModel: ObservableObject {
    
    
    
    
    func signOut() throws {
        try AuthenticationManager.shared.signOut()
    }
}

