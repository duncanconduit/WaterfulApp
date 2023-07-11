//
//  SettingsViewModel.swift
//  Waterful
//
//  Created by Duncan Conduit on 06/07/2023.
//  Copyright © 2023 Duncan Conduit. All rights reserved.
//

import Foundation

@MainActor
final class SettingsViewModel: ObservableObject {
    
    func signOut() throws {
        try AuthenticationManager.shared.signOut()
    }

}
