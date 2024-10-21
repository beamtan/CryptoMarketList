//
//  CoinDetailView.swift
//  CryptoMarketList
//
//  Created by Chayakan Tangsanga on 20/10/2567 BE.
//

import SwiftUI
import Kingfisher
import SwifterSwift

struct CoinDetailView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State var coin: MarketWatchModel? = nil
    @State var graphData: [Double]
    @State var isPositivePricePercentChange: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .center, spacing: 0) {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 10, height: 16)
                        .foregroundColor(Color("212529"))
                }
                
                if let url = URL(string: coin?.image ?? "") {
                    KFImage(url)
                        .placeholder {
                            ProgressView()
                        }
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        .padding(.leading, 16)
                }
                
                Text(coin?.name ?? "")
                    .font(Font.custom("CircularStd-Book", size: 16))
                    .foregroundStyle(Color("212529"))
                    .frame(maxHeight: .infinity)
                    .padding(.leading, 8)
                
                Text("(\(coin?.symbol?.uppercased() ?? ""))")
                    .font(Font.custom("CircularStd-Book", size: 10))
                    .foregroundStyle(Color.gray)
                    .frame(maxHeight: .infinity)
                    .padding(.leading, 4)
                
                Image(systemName: "star")
                    .frame(width: 16, height: 16)
                    .foregroundColor(Color("212529"))
                    .padding(.leading, 12)
                
                Spacer()
                
            }
            .frame(maxWidth: .infinity, maxHeight: 30)
            .padding(.horizontal, 16)
            .background(Color("F8F9FA"))
            
            ScrollView {
                VStack(spacing: 0) {
                    HStack(alignment: .center, spacing: 0) {
                        Text("$\(coin?.currentPrice?.currencyFormatted(digits: 2) ?? "")")
                            .font(Font.custom("CircularStd-Bold", size: 24))
                            .foregroundStyle(Color("212529"))
                            .frame(maxHeight: .infinity, alignment: .bottomLeading)
                        
                        Text("\(coin?.priceChange24H?.currencyFormatted(digits: 2) ?? "") (\(coin?.priceChangePercentage24H?.currencyFormatted(digits: 2) ?? "")%)")
                            .font(Font.custom("CircularStd-Book", size: 16))
                            .foregroundStyle(isPositivePricePercentChange ? Color.green : Color.red)
                            .frame(maxHeight: .infinity, alignment: .bottomLeading)
                            .padding(.leading, 12)
                        
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, maxHeight: 26)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 16)
                    
                    GraphViewWithLabel(graphData: graphData)
                    
                    StatisticsView(coin: coin)
                    
                    Spacer()
                }
            }
            .navigationBarBackButtonHidden(true)
            .background(Color("F8F9FA"))
        }
    }
}

struct StatisticsView: View {
    let coin: MarketWatchModel?
    
    var body: some View {
        let rangeFromLowestToCurrentPrice: Double = max(1, ((coin?.currentPrice ?? 0.0) - (coin?.low24H ?? 0.0)))
        let percentOfCurrentPriceCompareToHighest: Double = min(1, rangeFromLowestToCurrentPrice / (coin?.high24H ?? 0.0))
        
        VStack {
            Rectangle()
                .foregroundStyle(Color("DFE2E4"))
        }
        .frame(maxWidth: .infinity, maxHeight: 1)
        .padding(.horizontal, 16)
        .padding(.vertical, 20)
        
        HStack {
            Text("Statistics")
                .font(Font.custom("CircularStd-Book", size: 16))
                .foregroundStyle(Color("212529"))
                .frame(maxHeight: .infinity)
            
            Spacer()
        }
        .padding(.horizontal, 16)
        
        HStack {
            Text("Low / High 24h.")
                .font(Font.custom("CircularStd-Book", size: 12))
                .foregroundStyle(Color("6C757D"))
                .frame(maxHeight: .infinity)
            
            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.top, 24)
        
        VStack {
            ProgressView(
                value: percentOfCurrentPriceCompareToHighest,
                total: 1
            )
                .tint(Color("6C757D"))
        }
        .frame(maxWidth: .infinity, maxHeight: 6)
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        
        HStack {
            Text("\(coin?.low24H?.currencyFormatted(digits: 2) ?? "--")")
                .font(Font.custom("CircularStd-Book", size: 12))
                .foregroundStyle(Color("212529"))
                .frame(maxHeight: .infinity)
            
            Spacer()
            
            Text("\(coin?.high24H?.currencyFormatted(digits: 2) ?? "--")")
                .font(Font.custom("CircularStd-Book", size: 12))
                .foregroundStyle(Color("212529"))
                .frame(maxHeight: .infinity)
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 24)
        
        // MARK: - TableView
        
        Group {
            HStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 8) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Market Cap")
                            .font(Font.custom("CircularStd-Book", size: 12))
                            .foregroundStyle(Color("6C757D"))
                            .frame(maxHeight: .infinity)
                        Text("$\(coin?.marketCap?.string ?? "--")")
                            .font(Font.custom("CircularStd-Book", size: 12))
                            .foregroundStyle(Color("212529"))
                            .frame(maxHeight: .infinity)
                    }
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Fully Diluted Market Cap")
                            .font(Font.custom("CircularStd-Book", size: 12))
                            .foregroundStyle(Color("6C757D"))
                            .frame(maxHeight: .infinity)
                        Text("\(coin?.fullyDilutedValuation?.currencyFormatted(digits: 2) ?? "--")")
                            .font(Font.custom("CircularStd-Book", size: 12))
                            .foregroundStyle(Color("212529"))
                            .frame(maxHeight: .infinity)
                    }
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Max Supply")
                            .font(Font.custom("CircularStd-Book", size: 12))
                            .foregroundStyle(Color("6C757D"))
                            .frame(maxHeight: .infinity)
                        Text("\(coin?.maxSupply?.string ?? "--")")
                            .font(Font.custom("CircularStd-Book", size: 12))
                            .foregroundStyle(Color("212529"))
                            .frame(maxHeight: .infinity)
                    }
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("All Time High")
                            .font(Font.custom("CircularStd-Book", size: 12))
                            .foregroundStyle(Color("6C757D"))
                            .frame(maxHeight: .infinity)
                        Text("\(coin?.ath?.string ?? "--")")
                            .font(Font.custom("CircularStd-Book", size: 12))
                            .foregroundStyle(Color("212529"))
                            .frame(maxHeight: .infinity)
                    }
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("All Time Low")
                            .font(Font.custom("CircularStd-Book", size: 12))
                            .foregroundStyle(Color("6C757D"))
                            .frame(maxHeight: .infinity)
                        Text("\(coin?.atl?.string ?? "--")")
                            .font(Font.custom("CircularStd-Book", size: 12))
                            .foregroundStyle(Color("212529"))
                            .frame(maxHeight: .infinity)
                    }
                }
                
                Spacer()
                
                VStack {
                    Rectangle()
                        .foregroundStyle(Color("DFE2E4"))
                }
                .frame(maxWidth: 1, maxHeight: .infinity)
                
                VStack(alignment: .leading, spacing: 8) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Fully Diluted Market Cap")
                            .font(Font.custom("CircularStd-Book", size: 12))
                            .foregroundStyle(Color("6C757D"))
                            .frame(maxHeight: .infinity)
                        Text("$\(coin?.fullyDilutedValuation?.string ?? "--")")
                            .font(Font.custom("CircularStd-Book", size: 12))
                            .foregroundStyle(Color("212529"))
                            .frame(maxHeight: .infinity)
                    }
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Circulating Supply")
                            .font(Font.custom("CircularStd-Book", size: 12))
                            .foregroundStyle(Color("6C757D"))
                            .frame(maxHeight: .infinity)
                        Text("\(coin?.circulatingSupply?.currencyFormatted(digits: 2) ?? "--")")
                            .font(Font.custom("CircularStd-Book", size: 12))
                            .foregroundStyle(Color("212529"))
                            .frame(maxHeight: .infinity)
                    }
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Total Supply")
                            .font(Font.custom("CircularStd-Book", size: 12))
                            .foregroundStyle(Color("6C757D"))
                            .frame(maxHeight: .infinity)
                        Text("\(coin?.maxSupply?.string ?? "--")")
                            .font(Font.custom("CircularStd-Book", size: 12))
                            .foregroundStyle(Color("212529"))
                            .frame(maxHeight: .infinity)
                    }
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Rank")
                            .font(Font.custom("CircularStd-Book", size: 12))
                            .foregroundStyle(Color("6C757D"))
                            .frame(maxHeight: .infinity)
                        Text("#\(coin?.marketCapRank?.string ?? "--")")
                            .font(Font.custom("CircularStd-Book", size: 12))
                            .foregroundStyle(Color("212529"))
                            .frame(maxHeight: .infinity)
                    }
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Market Dominance")
                            .font(Font.custom("CircularStd-Book", size: 12))
                            .foregroundStyle(Color("6C757D"))
                            .frame(maxHeight: .infinity)
                        Text("--")
                            .font(Font.custom("CircularStd-Book", size: 12))
                            .foregroundStyle(Color("212529"))
                            .frame(maxHeight: .infinity)
                    }
                }
                .padding(.leading, 16)
                
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 16)
        }
    }
}

struct GraphViewWithLabel: View {
    let graphData: [Double]
    
    var body: some View {
        
        HStack(alignment: .bottom) {
            GeometryReader { geometry in
                let maxValue: Double = graphData.max() ?? 1
                let minValue: Double = graphData.min() ?? 1
                
                let eachStepOfXLength: CGFloat = geometry.size.width / CGFloat(graphData.count - 1)
                
                let indexOfMaxValue: Int = graphData.firstIndex(where: { $0 == maxValue }) ?? 0
                let indexOfMinValue: Int = graphData.firstIndex(where: { $0 == minValue }) ?? 0
                
                let paddingOfMaxValue: CGFloat = CGFloat(indexOfMaxValue) * eachStepOfXLength
                let paddingOfMinValue: CGFloat = CGFloat(indexOfMinValue) * eachStepOfXLength
                
                /// Prevent padding push too much off horizontal screen
                
                let isInTheRightEdgeScreen: Bool = indexOfMaxValue >= (graphData.count - 2)
                let isInTheLeftEdgeScreen: Bool = indexOfMaxValue <= 2
                
                /// Choose padding for most align to the price label
                
                let defaultAlignPadding: CGFloat = isInTheLeftEdgeScreen ? 0 : paddingOfMaxValue - CGFloat(eachStepOfXLength * 1)
                let preventOffScreenToRightPadding: CGFloat = paddingOfMaxValue - CGFloat(eachStepOfXLength * 2)
                
                let padding: CGFloat = isInTheRightEdgeScreen ? preventOffScreenToRightPadding : defaultAlignPadding
                
                Text("$" + maxValue.currencyFormatted(digits: 2))
                    .font(Font.custom("CircularStd-Book", size: 12))
                    .foregroundStyle(Color("6C757D"))
                    .padding(.leading, padding)
            }
        }
        .frame(maxWidth: .infinity, minHeight: 20)
        
        GraphView(
            graphLineColor: Color("0063F5"),
            prices: graphData
        )
        .frame(maxWidth: .infinity, minHeight: 320)
        .padding(.vertical, 8)
        
        HStack {
            GeometryReader { geometry in
                let maxValue: Double = graphData.max() ?? 1
                let minValue: Double = graphData.min() ?? 1
                
                let eachStepOfXLength: CGFloat = geometry.size.width / CGFloat(graphData.count - 1)
                
                let indexOfMaxValue: Int = graphData.firstIndex(where: { $0 == maxValue }) ?? 0
                let indexOfMinValue: Int = graphData.firstIndex(where: { $0 == minValue }) ?? 0
                
                let paddingOfMaxValue: CGFloat = CGFloat(indexOfMaxValue) * eachStepOfXLength
                let paddingOfMinValue: CGFloat = CGFloat(indexOfMinValue) * eachStepOfXLength
                
                /// Prevent padding push too much off horizontal screen
                
                let isInTheRightEdgeScreen: Bool = indexOfMinValue >= (graphData.count - 2)
                let isInTheLeftEdgeScreen: Bool = indexOfMinValue <= 2
                
                /// Choose padding for most align to the price label
                
                let defaultAlignPadding: CGFloat = isInTheLeftEdgeScreen ? 0 : paddingOfMinValue - CGFloat(eachStepOfXLength * 1)
                let preventOffScreenToRightPadding: CGFloat = paddingOfMinValue - CGFloat(eachStepOfXLength * 2)
                
                let padding: CGFloat = isInTheRightEdgeScreen ? preventOffScreenToRightPadding : defaultAlignPadding
                
                Text("$" + minValue.currencyFormatted(digits: 2))
                    .font(Font.custom("CircularStd-Book", size: 12))
                    .foregroundStyle(Color("6C757D"))
                    .padding(.leading, padding)
            }
        }
        .frame(maxWidth: .infinity, minHeight: 20)
    }
}

#Preview {
    let sampleGraphData: [Double] = [
        48000, 48500, 49000, 49500, 50000, 50500, 51000,
        51500, 52000, 52500, 53000, 53500, 54000, 54500,
        55000, 55500, 56000, 56500, 57000, 57500,
    ].shuffled()
    
    let isPositiveChange = true
    
    CoinDetailView(
        graphData: sampleGraphData,
        isPositivePricePercentChange: isPositiveChange
    )
}
