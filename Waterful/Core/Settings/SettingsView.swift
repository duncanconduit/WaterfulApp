//
//  SettingsView.swift
//  Waterful
//
//  Created by Duncan Conduit on 26/10/2023.
//  Copyright © 2023 Duncan Conduit. All rights reserved.
//

import SwiftUI



struct SettingsView: View {
    
    @Environment(\.easyDismiss) var easyDismiss: EasyDismiss
    @State var selectedAppearance = UserDefaults.standard.integer(forKey: "appearance")
    @State private var scrollPosition: CGPoint = .zero
    @StateObject private var viewModel = SettingsViewModel()

    
    var body: some View {
       
        VStack {
            VStack {
                
                Spacer()
                    .frame(maxHeight: 20)
                
                
                HStack {
                    
                    
                    Text("Settings")
                        .font(.system(.largeTitle, design: .rounded))
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundStyle(.navTitle)
                        .padding()
                    
                    Button {
                        withAnimation {
                            easyDismiss()
                        }
                    } label: {
                        Image(systemName: "xmark.circle")
                            .resizable()
                            .scaledToFit()
                            .font(.system(.largeTitle, design: .rounded))
                            .frame(width: 40,height: 40, alignment: .trailing)
                            .foregroundStyle(.gray)
                            .padding()
                        
                    }
                    
                }
            }
            
        
                
            
        ScrollView {
            
              
            VStack {
                
                
                VStack {
                    Text("Appearance")
                        .font(.system(.title3, design: .default))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .bold()
                        .foregroundStyle(.navTitle)
                    
                    Text("Customise the appearance of the app.")
                        .font(.system(.body, design: .default))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundStyle(.gray)
                }
                .padding(.leading, 10)
                
                SettingsViewModel.AppearanceButtonView(selectedAppearance: $selectedAppearance, allCases: SettingsViewModel.Appearance.allCases)
    
                }
                .padding()
                
            VStack {
                
                VStack {
                    Text("Notifications")
                        .font(.system(.title3, design: .rounded))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .bold()
                        .foregroundStyle(.navTitle)
                    
                    Text("Customise the notifications of the app")
                        .font(.system(.body, design: .rounded))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundStyle(.gray)
                    
                    Button {
                        print(scrollPosition.y)
                    } label: {
                        Text("test")
                    }
                }
                .padding(.leading, 10)
            }
                .padding()
                
                Spacer(minLength: 200)
              
            
            
        .background(GeometryReader { geometry in
                            Color.clear
                .preference(key: SettingsViewModel.ScrollOffsetPreferenceKey.self, value: geometry.frame(in: .named("scroll")).origin)
                        })
        .onPreferenceChange(SettingsViewModel.ScrollOffsetPreferenceKey.self) { value in
                            self.scrollPosition = value
                        }
    
            }
            
            
            
        }
        .background(.appearance)
        .onChange(of: selectedAppearance) {
            Utilities().overrideDisplayMode()
        }
    }
        

}



#Preview {
    SettingsView()
}
