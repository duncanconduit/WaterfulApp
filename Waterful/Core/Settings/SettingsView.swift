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
    @Binding var selectedAppearance: SettingsViewModel.Appearance 
    
    @State var  isSelectedL = false
    @State var isSelectedD = false
    @State var isSelectedS = false
    
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
                        .foregroundStyle(Color("Color1"))
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
                        .foregroundStyle(Color("Color1"))
                    
                    Text("Customise the appearance of the app.")
                        .font(.system(.body, design: .default))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundStyle(.gray)
                }
                .padding(.leading, 10)
                
                SettingsViewModel.AppearanceButtonView(selectedTab: $selectedAppearance, allCases: SettingsViewModel.Appearance.allCases)
    
                }
                .padding()
                
                VStack {
                    
                    VStack {
                        Text("Notifications")
                            .font(.system(.title3, design: .rounded))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .bold()
                            .foregroundStyle(Color("Color1"))
                        
                        Text("Customise the notifications of the app")
                            .font(.system(.body, design: .rounded))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundStyle(.gray)
                    }
                    .padding(.leading, 10)
                }
                .padding()
                
                Spacer(minLength: 200)
                
            }
           
            
            
            
        }
        .background(.white)
       
        
    }
      

}



#Preview {
    SettingsView(selectedAppearance: .constant(SettingsViewModel.Appearance.light))
}
