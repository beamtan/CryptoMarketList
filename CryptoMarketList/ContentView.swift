//
//  ContentView.swift
//  CryptoMarketList
//
//  Created by Chayakan Tangsanga on 18/10/2567 BE.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
                .font(Font.custom("SFMono-Bold", size: 20))
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
