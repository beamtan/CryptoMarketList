//
//  Secrets.swift
//  CryptoMarketList
//
//  Created by Chayakan Tangsanga on 19/10/2567 BE.
//

import Foundation

struct Secrets {
    static var coinGeckoApiKey: String? {
        return Bundle.main.infoDictionary?["ApiKey"] as? String
    }
}
