//
//  Orders.swift
//  Chimere
//
//  Created by Damien Rojo on 29.04.20.
//  Copyright © 2020 Damien Rojo. All rights reserved.
//

import Foundation

struct UserOrders {
//    var state: Status
    let id: String
    let originAmount: String
    let originSymbol: String
    let originAddress: String
    let destinationAmount: String
    let destinationSymbol: String
    let destinationAddress: String
    let createdDate: String
}

struct Status {
    var loaded = false
    var exchanging = false
    var completed = false
    var expired = false
    var failed = false
}
