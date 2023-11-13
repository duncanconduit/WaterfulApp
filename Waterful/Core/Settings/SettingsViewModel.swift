//
//  SettingsViewModel.swift
//  Waterful
//
//  Created by Duncan Conduit on 31/06/2023.
//  Copyright © 2023 Duncan Conduit. All rights reserved.
//

import SwiftUI

/// A protocol that defines the properties that an appearance option should have.
public protocol AppearanceProtocol: CaseIterable, Hashable, Encodable, Decodable {
    var tag: Int { get }
    var imageName: String { get }
    var title: String { get }
    var subTitle: String { get }
    var foregroundColor: Color { get }
    var backgroundColor: Color { get }
}

/// A view that displays an appearance option and allows the user to select it.
final class SettingsViewModel: ObservableObject {
    
    /// An enum that represents the available appearance options.
    enum Appearance: AppearanceProtocol {
        case light
        case dark
        case system
        
        var tag: Int {
            switch self {
            case .light:
                return 0
            case .dark:
                return 1
            case .system:
                return 2
            }
        }
        
        var title: String {
            switch self {
            case .light:
                return "Light"
            case .dark:
                return "Dark"
            case .system:
                return "System"
            }
        }
        
        var subTitle: String {
            switch self {
            case .light:
                return "Always uses light appearance."
            case .dark:
                return "Always uses the light appearance."
            case .system:
                return "Automatic baded on device settings."
            }
        }
        
        var imageName: String {
            switch self {
            case .light:
                return "sun.max"
            case .dark:
                return "moon"
            case .system:
                return "gear"
            }
        }
        
        var foregroundColor: Color {
            switch self {
            case .light:
                return .black
            case .dark:
                return .white
            case .system:
                return .black
            }
        }
        
        var backgroundColor: Color {
            switch self {
            case .light:
                return .white
            case .dark:
                return .black
            case .system:
                return .gray
            }
        }
        
    }
    
    /// A view that displays an appearance option and allows the user to select it.
    struct AppearanceButton<T: AppearanceProtocol>: View {
        var currentTab: T
        @Binding var selectedAppearance: Int
        
        var body: some View {
            
            HStack {
                
                Text("Aa")
                    .scaledToFit()
                    .font(.system(size: 30))
                    .frame(width: 50, height: 50)
                    .fontWeight(.semibold)
                    .foregroundStyle(currentTab.foregroundColor)
                    .background(currentTab.backgroundColor)
                    .cornerRadius(10)
                    .padding(10)
                
                VStack {
                    
                    Text(currentTab.title)
                        .scaledToFit()
                        .font(.system(.subheadline))
                        .foregroundStyle(.navTitle)
                        .frame(minWidth: 150, alignment: .leading)
                    
                    Text(currentTab.subTitle)
                        .scaledToFit()
                        .font(.system(.caption))
                        .foregroundStyle(.gray)
                        .frame(minWidth: 250, alignment: .leading)
                    
                    
                }
                .padding(.horizontal, 10)
                .frame(minWidth: 250,alignment: .leading)
                .scaledToFit()
                
                
                
                
                Image(systemName: selectedAppearance == currentTab.tag ? "checkmark.circle" : "")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25, height: 50, alignment: .trailing)
                    .foregroundColor(currentTab.foregroundColor)
                    .padding(.trailing, 3)
                
            }
            .frame(height: 65, alignment: .leading)
            .scaledToFit()
            .aspectRatio(contentMode: .fit)
            .background(.regularMaterial)
            .cornerRadius(15)
            .buttonStyle(.plain)
            .simultaneousGesture(TapGesture().onEnded {
                selectedAppearance = currentTab.tag
                UserDefaults.standard.set(currentTab.tag, forKey: "appearance")
            })
            
            
        }
        
    }
    
    /// A view that displays all the available appearance options.
    struct AppearanceButtonView<T: AppearanceProtocol>: View {
        
        @Binding var selectedAppearance: Int
        let allCases: [T]
        
        var body: some View {
            VStack {
                ForEach(allCases, id: \.self) { tab in
                    AppearanceButton(currentTab: tab, selectedAppearance: $selectedAppearance)
                    
                }
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity, alignment: .leading)
                
            }
            
        }
    }
    
    /// A preference key used to store the scroll offset of a view.
    struct ScrollOffsetPreferenceKey: PreferenceKey {
        static var defaultValue: CGPoint = .zero
        
        static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {
        }
    }
    
}
