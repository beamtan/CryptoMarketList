//
//  MarketWatchView.swift
//  CryptoMarketList
//
//  Created by Chayakan Tangsanga on 18/10/2567 BE.
//

import SwiftUI

struct MarketWatchView: View {
    var body: some View {
        ScrollView {
            VStack {
                MarketWatchWelcomeHeaderView()
                
                Text("Trending Coins")
                    .font(Font.custom("CircularStd-Bold", size: 20))
                    .frame(maxWidth: .infinity, maxHeight: 20, alignment: .leading)
                    .padding(.top, 32)
                
                ForEach(0..<5) { _ in
                    CoinCardView()
                }
                
                Spacer()
            }
            .padding(16)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("F8F9FA", bundle: .main))
            
        }
        .background(Color("F8F9FA", bundle: .main))
//        .background(Color.brown)
    }
}

struct Stock {
    let price: Double
}

func getHistoricalData() -> [Stock] {
    var stock: [Stock] = []
    
    var something = getDouble()
    for i in 1...20 {
        let stock2 = Stock(price: Double.random(in: 100...300))
//        let stock2 = Stock(price: something[i])
        stock.append(stock2)
    }
    
    return stock
}

private func getYearlyLabels() -> [String] {
    return (2015...2021).map { String($0) }
}

private func getDouble() -> [Double] {
    return (100...120).map { Double($0) }
}

struct GraphView: View {
    let prices = getHistoricalData().map { Int($0.price) }
    let labels = getYearlyLabels()
    
    var body: some View {
        LineView(
            values: prices,
            labels: labels
        )
        .frame(width: 50, height: 25)
    }
}

struct LineView: View {
    let values: [Int]
    let labels: [String]
//    var screenWidth = UIScreen.main.bounds.width - 32
    
    var body: some View {
        GeometryReader { geometry in
            let maxValue = CGFloat(values.max() ?? 1)
            let minValue = CGFloat(values.min() ?? 1)
            let range = maxValue - minValue
            let stepX = geometry.size.width / CGFloat(values.count - 1)
            
            Path { path in
                guard !values.isEmpty else { return }
                
                let firstY = geometry.size.height - ((CGFloat(values[0]) - minValue) / range) * geometry.size.height
                path.move(to: CGPoint(x: 0, y: firstY))
                
                for index in 1..<values.count {
                    let x = CGFloat(index) * stepX
                    let y = geometry.size.height - ((CGFloat(values[index]) - minValue) / range) * geometry.size.height
                    path.addLine(to: CGPoint(x: x, y: y))
                }
            }
            .stroke(Color.green, lineWidth: 2)
        }
    }
}

struct CoinCardView: View {
    @State var coinName: String = "Bitcoin"
    @State var coinSymbol: String = "BTC"
    
    @State var price: String = "$2,509.75"
    @State var percentChange: String = "+9.77%"
    
    @State private var graphOffsetX: CGFloat = 0
    
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            Image("japaneseCircle")
                .resizable()
                .frame(width: 40, height: 40, alignment: .leading)
            
            VStack(spacing: 8) {
                Text(coinName)
                    .font(Font.custom("CircularStd-Book", size: 16))
                    .frame(maxWidth: .infinity, maxHeight: 12, alignment: .leading)
                
                Text(coinSymbol)
                    .font(Font.custom("CircularStd-Medium", size: 12))
                    .foregroundStyle(Color.gray)
                    .frame(maxWidth: .infinity, maxHeight: 12, alignment: .leading)
            }
            .padding(.leading, 12)
            
            Spacer()
            
            GraphView()
                .frame(width: 50, height: 25, alignment: .trailing)
            
            VStack(spacing: 8) {
                Text(price)
                    .font(Font.custom("CircularStd-Book", size: 16))
                    .frame(maxWidth: .infinity, maxHeight: 12, alignment: .trailing)
                
                Text(percentChange)
                    .font(Font.custom("CircularStd-Medium", size: 12))
                    .foregroundStyle(Color.green)
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

#Preview {
    MarketWatchView()
}
