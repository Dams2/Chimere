//
//  DepositResponse.swift
//  Chimere
//
//  Created by Damien Rojo on 21.04.20.
//  Copyright © 2020 Damien Rojo. All rights reserved.
//

import Foundation

// MARK: - DepositResponse
struct DepositResponse: Codable {
    let order: Order
}

// MARK: - Order
struct Order: Codable {
    let state: State
    let id, owner: String?
    let depositAmount: Double
    let depositTicker, depositAddress, destinationTicker, destinationAddress: String
    let destinationAmount: Double
    let refundAddress, createdDate: String

    enum CodingKeys: String, CodingKey {
        case state
        case id = "_id"
        case owner
        case depositAmount = "deposit_amount"
        case depositTicker = "deposit_ticker"
        case depositAddress = "deposit_address"
        case destinationTicker = "destination_ticker"
        case destinationAddress = "destination_address"
        case destinationAmount = "destination_amount"
        case refundAddress = "refund_address"
        case createdDate = "created_date"
    }
}

// MARK: - State
struct State: Codable {
    let loaded, exchanging, completed, expired: Bool
}
