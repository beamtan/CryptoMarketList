//
//  MarketWatchView.swift
//  CryptoMarketList
//
//  Created by Chayakan Tangsanga on 18/10/2567 BE.
//

import SwiftUI
import Kingfisher

struct MarketWatchView: View {
    @StateObject private var viewModel = MarketWatchViewModel()
    
    var body: some View {
        ScrollView {
            VStack {
                MarketWatchWelcomeHeaderView()
                
                Text("Trending Coins")
                    .font(Font.custom("CircularStd-Bold", size: 20))
                    .frame(maxWidth: .infinity, maxHeight: 20, alignment: .leading)
                    .padding(.top, 32)
                
                VStack {
                    ForEach(viewModel.coins) { coin in
                        CoinCardView(
                            imageUrl: coin.image ?? "",
                            graphData: (coin.sparkLineIn7D?.price ?? []).suffix(20),
                            coinName: coin.name ?? "",
                            coinSymbol: coin.symbol ?? "",
                            price: coin.currentPrice ?? 0.0,
                            percentChange: coin.priceChange24H ?? 0.0,
                            isPositivePricePercentChange: coin.isPositivePriceChange24H
                        )
                    }
                }
                .padding(.top, 16)
                
                Spacer()
            }
            .padding(16)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("F8F9FA", bundle: .main))
            
        }
        .background(Color("F8F9FA", bundle: .main))
        .onAppear {
            viewModel.inquiryCoinList()
        }
    }
}

// MARK: - Header

struct MarketWatchWelcomeHeaderView: View {
    var body: some View {
        ZStack {
            HStack {
                Image("japaneseCircle")
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            
            VStack {
                Text("Welcome Beamtan")
                    .font(Font.custom("CircularStd-Book", size: 12))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, maxHeight: 12, alignment: .leading)
                
                Text("Make your first Investment today")
                    .font(Font.custom("CircularStd-Bold", size: 15))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, maxHeight: 12, alignment: .leading)
                    .padding(.top, 8)
                
                HStack {
                    Text("Invest Today")
                        .font(Font.custom("CircularStd-Book", size: 12))
                        .foregroundStyle(Color("0063F5", bundle: .main))
                        .frame(maxWidth: 92)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 12)
                        .background(Color.white)
                        .cornerRadius(4)
                        .padding(.top, 16)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
            }
            .frame(maxWidth: .infinity, maxHeight: 141)
            .padding(.horizontal, 20)
            .cornerRadius(12)
        }
        .background(Color("0063F5", bundle: .main))
        .cornerRadius(12)
    }
}

// MARK: - CoinCardView

struct CoinCardView: View {
    @State var imageUrl: String
    @State var graphData: [Double]
    
    @State var coinName: String = "Bitcoin"
    @State var coinSymbol: String = "BTC"
    
    @State var price: Double = 2509.75
    @State var percentChange: Double = 9.77
    
    @State var isPositivePricePercentChange: Bool
    
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            if let url = URL(string: imageUrl) {
                KFImage(url)
                    .placeholder {
                        ProgressView()
                    }
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40, alignment: .leading)
            }
            
            VStack(spacing: 8) {
                Text(coinName)
                    .font(Font.custom("CircularStd-Book", size: 16))
                    .frame(maxWidth: .infinity, maxHeight: 12, alignment: .leading)
                
                Text(coinSymbol.uppercased())
                    .font(Font.custom("CircularStd-Medium", size: 12))
                    .foregroundStyle(Color.gray)
                    .frame(maxWidth: .infinity, maxHeight: 12, alignment: .leading)
            }
            .padding(.leading, 12)
            
            Spacer()
            
            GraphView(
                isPositivePricePercentChange: isPositivePricePercentChange,
                prices: graphData
            )
                .frame(width: 50, height: 25, alignment: .trailing)
            
            VStack(spacing: 8) {
                Text("$ \(price.currencyFormatted(digits: 2))")
                    .font(Font.custom("CircularStd-Book", size: 16))
                    .frame(maxWidth: .infinity, maxHeight: 12, alignment: .trailing)
                
                Text(isPositivePricePercentChange ? "+\(percentChange)%" : "\(percentChange.currencyFormatted(digits: 2))%")
                    .font(Font.custom("CircularStd-Medium", size: 12))
                    .foregroundStyle(isPositivePricePercentChange ? Color.green : Color.red)
                    .frame(maxWidth: .infinity, maxHeight: 12, alignment: .trailing)
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity, minHeight: 72)
        .cornerRadius(8)
        .background(Color.white)
        .cornerRadius(8)
        .shadow(
            color: Color.black.opacity(0.1),
            radius: 10,
            x: 0,
            y: 5
        )
    }
}

// MARK: - Graph

struct GraphView: View {
    let isPositivePricePercentChange: Bool
    var prices: [Double]
    
    var body: some View {
        GeometryReader { geometry in
            let maxValue = CGFloat(prices.max() ?? 1)
            let minValue = CGFloat(prices.min() ?? 1)
            let range = maxValue - minValue
            let stepX = geometry.size.width / CGFloat(prices.count - 1)
            
            Path { path in
                guard !prices.isEmpty else { return }
                
                let firstY = geometry.size.height - ((CGFloat(prices[0]) - minValue) / range) * geometry.size.height
                path.move(to: CGPoint(x: 0, y: firstY))
                
                for index in 1..<prices.count {
                    let x = CGFloat(index) * stepX
                    let y = geometry.size.height - ((CGFloat(prices[index]) - minValue) / range) * geometry.size.height
                    path.addLine(to: CGPoint(x: x, y: y))
                }
            }
            .stroke(
                isPositivePricePercentChange ? Color.green : Color.red,
                lineWidth: 2
            )
        }
        .frame(width: 50, height: 25)
    }
}

#Preview {
    MarketWatchView()
}
