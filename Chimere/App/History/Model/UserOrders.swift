//
//  Orders.swift
//  Chimere
//
//  Created by Damien Rojo on 29.04.20.
//  Copyright © 2020 Damien Rojo. All rights reserved.
//

import Foundation

struct UserOrders {
    let state: [String: Bool]
    let id: String
    let originAmount: String
    let originSymbol: String
    let depositAddress: String
    let destinationAmount: String
    let destinationSymbol: String
    let destinationAddress: String
    let createdDate: String
}
