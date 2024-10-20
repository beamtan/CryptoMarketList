//
//  Service.swift
//  CryptoMarketList
//
//  Created by Chayakan Tangsanga on 20/10/2567 BE.
//

import Alamofire
import Combine

protocol Service {
    func inquiryCoinList() -> AnyPublisher<[MarketWatchModel], AFError>
}

class CoinGeckoService: Service {
    func inquiryCoinList() -> AnyPublisher<[MarketWatchModel], AFError> {
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(Secrets.coinGeckoApiKey ?? "")",
            "Accept": "application/json"
        ]
        
        let parameters: [String: Any] = [
            "vs_currency" : "usd",
            "precision" : "2",
            "per_page" : 20,
            "sparkline" : "true",
            "order" : "market_cap_desc",
        ]
        
        let request = AF.request(
            "https://api.coingecko.com/api/v3/coins/markets",
            method: .get,
            parameters: parameters,
            headers: headers
        )
            .validate()
            .publishDecodable(type: [MarketWatchModel].self)
            .value()
            .eraseToAnyPublisher()
        
        return request
    }
}
