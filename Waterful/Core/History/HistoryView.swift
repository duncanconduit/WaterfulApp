//
//  HistoryView.swift
//  Waterful
//
//  Created by Duncan Conduit on 01/11/2023.
//  Copyright © 2023 Duncan Conduit. All rights reserved.
//

import SwiftUI

struct HistoryView: View {
    @Environment(\.easyDismiss) var easyDismiss: EasyDismiss
    
    
    var body: some View {
        
        
        VStack {
            VStack {
                
                Spacer()
                    .frame(maxHeight: 20)
                
                
                HStack {
                    
                    
                    Text("History")
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
            
            Spacer(minLength: 200)
        }
        .background(.appearance)
    }
}

#Preview {
    HistoryView()
}
