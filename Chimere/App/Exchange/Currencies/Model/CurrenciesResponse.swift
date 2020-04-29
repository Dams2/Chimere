//
//  CurrenciesResponse.swift
//  antex
//
//  Created by Damien Rojo on 17.04.20.
//  Copyright © 2020 Damien Rojo. All rights reserved.
//

import Foundation

// MARK: - CurrenciesResponse
struct CurrenciesResponse: Codable {
    let asset: [Asset]
}

// MARK: - Asset
struct Asset: Codable {
    let imgURL: String
    let id, ticker, currency: String

    enum CodingKeys: String, CodingKey {
        case imgURL = "img_url"
        case id = "_id"
        case ticker, currency
    }
}
