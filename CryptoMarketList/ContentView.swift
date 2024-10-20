//
//  ContentView.swift
//  CryptoMarketList
//
//  Created by Chayakan Tangsanga on 18/10/2567 BE.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Group {
                NavigationStack {
                    MarketWatchView()
                }
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            }
            .toolbarBackground(.white, for: .tabBar)
            .toolbarBackground(.visible, for: .tabBar)
            
            Group {
                MarketWatchView()
                    .tabItem {
                        Label("Market", systemImage: "chart.xyaxis.line")
                    }
            }
            .toolbarBackground(.white, for: .tabBar)
            .toolbarBackground(.visible, for: .tabBar)
        }
    }
}

#Preview {
    ContentView()
}
