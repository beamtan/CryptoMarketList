//
//  MarketWatchViewModel.swift
//  CryptoMarketList
//
//  Created by Chayakan Tangsanga on 19/10/2567 BE.
//

import SwiftUI
import Combine

class MarketWatchViewModel: ObservableObject {
    private let service: Service = CoinGeckoService()
    private var cancellables = Set<AnyCancellable>()
    
    @Published var coins: [MarketWatchModel] = []
    
    func inquiryCoinList() {
        service.inquiryCoinList()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self else { return }
                
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error: \(error)")
                }
            }, receiveValue: { [weak self] coins in
                guard let self else { return }
                
                self.coins = coins
                print(coins)
            })
            .store(in: &cancellables)
    }
}
