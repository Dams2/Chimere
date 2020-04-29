//
//  Deposit+DepositResponse.swift
//  Chimere
//
//  Created by Damien Rojo on 21.04.20.
//  Copyright © 2020 Damien Rojo. All rights reserved.
//

import Foundation

extension Deposit {
    init(response: OrderResponse) {
        self.id = "\(response.order.id)"
        self.depositAmount = "\(response.order.depositAmount)"
        self.depositSymbol = "\(response.order.depositTicker)"
        self.depositAddress = "\(response.order.depositAddress)"
        self.destinationAmount = "\(response.order.destinationAmount)"
        self.destinationSymbol = "\(response.order.destinationTicker)"
        self.destinationAddress = "\(response.order.destinationAddress)"
        self.createdDate = "\(response.order.createdDate)"
    }
}
