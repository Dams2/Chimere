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
    let askPrice, bidPrice: Price
    let askMin, askMax: String
}

// MARK: - Price
struct Price: Codable {
    let ticker, exchange: String
    let bestAsk: String?
    let bestBid: String?

    enum CodingKeys: String, CodingKey {
        case ticker, exchange
        case bestAsk = "best_ask"
        case bestBid = "best_bid"
    }
}
