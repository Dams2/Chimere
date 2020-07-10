//
//  UserOrders+UserOrdersResponse.swift
//  Chimere
//
//  Created by Damien Rojo on 30.04.20.
//  Copyright © 2020 Damien Rojo. All rights reserved.
//

import Foundation

extension UserOrders {
    init(response: Order) {
        self.id = "\(response.id ?? "")"
        self.originAmount = "\(response.depositAmount)"
        self.originSymbol = "\(response.depositTicker)"
        self.depositAddress = "\(response.depositAddress)"
        self.destinationAmount = "\(response.destinationAmount)"
        self.destinationSymbol = "\(response.destinationTicker)"
        self.destinationAddress = "\(response.destinationAddress)"
        self.createdDate = "\(response.createdDate)"
        
        // DateFormatter.dateFormatter(stringDate: response.createdDate)
        self.state = ["Loaded": response.state.loaded,
                      "Exchanging": response.state.exchanging,
                      "Exchanged": response.state.exchanged,
                      "Sending": response.state.sending,
                      "Completed": response.state.completed,
                      "Expired": response.state.expired,
                      "Failed": response.state.failed]
    }
}
