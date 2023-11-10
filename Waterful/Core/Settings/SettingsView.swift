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
                    .padding(.leading)
                    
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
                    }
                    .padding(.leading, 10)
                    
                    .padding()
                    
                   
                    Button {
                        
                        print(UserDefaults.standard.integer(forKey: "appearance"))
                    } label: {
                        HStack {
                            
                            
                        
                                
                                Image(systemName: "")
                                    .scaledToFit()
                                    .font(.system(size: 30))
                                    .frame(width: 50, height: 50)
                                    .fontWeight(.semibold)
                                    .cornerRadius(10)
                                    .padding()
                          
                            VStack {
                                
                                Text("Notifications")
                                    .scaledToFit()
                                    .font(.system(.subheadline))
                                    .foregroundStyle(.navTitle)
                                
                                Text("Enable Notifications")
                                    .scaledToFit()
                                    .font(.system(.caption))
                                    .foregroundStyle(.gray)
                                
                                
                            }
                            .padding()
                            .frame(minWidth: 80)
                            
                            
                            Spacer()
                                .frame(minWidth: 20)
                            
                            
                            Image(systemName: "chevron.right")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25, height: 50, alignment: .trailing)
                                .foregroundColor(.black)
                                .padding()
                            
                        }
                        .frame(height: 60)
                        .background(.regularMaterial)
                        .cornerRadius(10)
                        .buttonStyle(.plain)

                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .buttonStyle(.plain)
                    
                    
                       
                    
                }
                .padding()
                Spacer(minLength: 200)
                
            }
            
        }
        .background(Color("settingsColor"))
        .onChange(of: selectedAppearance) {
            Utilities().overrideDisplayMode()
        }
    }

}



#Preview {
    SettingsView()
}
