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
    let ticker: String
    let imgURL: String
    let currency, active, id: String
    let `protocol`: String?

    enum CodingKeys: String, CodingKey {
        case ticker
        case imgURL = "img_url"
        case currency, active, `protocol`
        case id = "_id"
    }
}
