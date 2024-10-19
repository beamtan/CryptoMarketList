//
//  Double+Extensions.swift
//  CryptoMarketList
//
//  Created by Chayakan Tangsanga on 20/10/2567 BE.
//

import Foundation

extension Double {
    func currencyFormatted(rule: NumberFormatStyleConfiguration.RoundingRule = .towardZero, digits: Int) -> String {
        return "\(self.formatted(.number.rounded(rule: rule).precision(.fractionLength(digits))))"
    }
}
