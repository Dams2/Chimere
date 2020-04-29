//
//  Orders+OrderResponse.swift
//  Chimere
//
//  Created by Damien Rojo on 29.04.20.
//  Copyright © 2020 Damien Rojo. All rights reserved.
//

import Foundation

extension Orders {
    init(response: OrderRespons) {
        self.id = "\(response.orders.first?.id)"
        self.depositAmount = "\(response.orders.first?.depositAmount)"
        self.depositSymbol = "\(response.orders.first?.depositTicker)"
        self.depositAddress = "\(response.orders.first?.depositAddress)"
        self.destinationAmount = "\(response.orders.first?.destinationAmount)"
        self.destinationSymbol = "\(response.orders.first?.destinationTicker)"
        self.destinationAddress = "\(response.orders.first?.destinationAddress)"
        self.createdDate = "\(response.orders.first?.createdDate)"
    }
}
