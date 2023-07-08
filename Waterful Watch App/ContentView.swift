//
//  ContentView.swift
//  WaterfulWatch Watch App
//
//  Created by Duncan Conduit on 06/07/2023.
//  Copyright © 2023 Duncan Conduit. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
