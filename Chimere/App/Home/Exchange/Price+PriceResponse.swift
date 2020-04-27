//
//  Price+PriceResponse.swift
//  Chimere
//
//  Created by Damien Rojo on 27.04.20.
//  Copyright © 2020 Damien Rojo. All rights reserved.
//

import Foundation

extension Price {
    init(response: PriceResponse) {
        self.askPlatform = "\(response.ask["exchange"])"
        self.askSymbol = "\(response.ask["ticker"])"
        self.bestAsk = "\(response.ask["bestAsk"])"
        self.bidPlatform = ""
        self.bidSymbol = ""
        self.bestBid = ""
    }
}
