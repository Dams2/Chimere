//
//  PriceResponse.swift
//  Chimere
//
//  Created by Damien Rojo on 27.04.20.
//  Copyright © 2020 Damien Rojo. All rights reserved.
//

import Foundation

// MARK: - PriceResponse
struct PriceResponse: Codable {
    let ask: [String: Ask]
    let bid: [String: Bid]
}

// MARK: - Ask
struct Ask: Codable {
    let ticker, exchange, bestAsk: String

    enum CodingKeys: String, CodingKey {
        case ticker, exchange
        case bestAsk = "best_ask"
    }
}

// MARK: - Bid
struct Bid: Codable {
    let ticker, exchange, bestBid: String

    enum CodingKeys: String, CodingKey {
        case ticker, exchange
        case bestBid = "best_bid"
    }
}
