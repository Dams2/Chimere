//
//  Deposit+DepositResponse.swift
//  Chimere
//
//  Created by Damien Rojo on 21.04.20.
//  Copyright © 2020 Damien Rojo. All rights reserved.
//

import Foundation

extension Deposit {
    init(response: Order) {
        self.id = "\(response.id)"
        self.depositAmount = "\(response.depositAmount)"
        self.depositSymbol = "\(response.depositTicker)"
        self.depositAddress = "\(response.depositAddress)"
        self.destinationAmount = "\(response.destinationAmount)"
        self.destinationSymbol = "\(response.destinationTicker)"
        self.destinationAddress = "\(response.destinationAddress)"
        self.createdDate = "\(response.createdDate)"
    }
}
