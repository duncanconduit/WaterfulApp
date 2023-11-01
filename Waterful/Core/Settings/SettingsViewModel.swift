//
//  SettingsViewModel.swift
//  Waterful
//
//  Created by Duncan Conduit on 31/10/2023.
//  Copyright © 2023 Duncan Conduit. All rights reserved.
//

    
    
import SwiftUI


public protocol AppearanceProtocol: CaseIterable, Hashable, Encodable, Decodable {
    var tag: Int { get }
    var imageName: String { get }
    var title: String { get }
    var foregroundColor: Color { get }
    var backgroundColor: Color { get }

    }


final class SettingsViewModel: ObservableObject {


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


    struct AppearanceButton<T: AppearanceProtocol>: View {
        var currentTab: T
        @Binding var selectedAppearance: Int

        var body: some View {
            Button {
                selectedAppearance = currentTab.tag
                UserDefaults.standard.set(currentTab.tag, forKey: "appearance")
                print(UserDefaults.standard.integer(forKey: "appearance"))
            } label: {
                HStack {
                    
                    Image(systemName: currentTab.imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25, height: 50)
                        .foregroundColor(currentTab.foregroundColor)
                        .padding()
                    
                    
                    Text(currentTab.title)
                        .font(.system(size: 15))
                        .fontWeight(.semibold)
                        .foregroundStyle(currentTab.foregroundColor)
                        .padding()
                    
                    Spacer()
                        .frame(minWidth: 90)
                    
                    Image(systemName: selectedAppearance == currentTab.tag ? "checkmark.circle" : "")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25, height: 50, alignment: .trailing)
                        .foregroundColor(currentTab.foregroundColor)
                        .padding()
                    
                }
                .frame(height: 80)
                .background(currentTab.backgroundColor)
                .cornerRadius(20)
                .buttonStyle(.plain)

            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .buttonStyle(.plain)
            
            
        }
    }


    struct AppearanceButtonView<T: AppearanceProtocol>: View {
        
        @Binding var selectedAppearance: Int
        let allCases: [T]
        
        var body: some View {
            VStack {
                ForEach(allCases, id: \.self) { tab in
                    AppearanceButton(currentTab: tab, selectedAppearance: $selectedAppearance)
            
                }
                
            }
            .padding()
            .aspectRatio(contentMode: .fit)
            .background(.regularMaterial)
            .cornerRadius(20) /// make the background rounded
            .frame(maxWidth: .infinity, alignment: .leading)
        
        }
    }
    
    
    struct ScrollOffsetPreferenceKey: PreferenceKey {
        static var defaultValue: CGPoint = .zero
        
        static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {
        }
    }
    
    
}


