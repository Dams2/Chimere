//
//  Currency+CurrenciesResponse.swift
//  antex
//
//  Created by Damien Rojo on 17.04.20.
//  Copyright © 2020 Damien Rojo. All rights reserved.
//

import Foundation

extension Currency {
    init(response: Asset) {
        self.imgURL = "\(response.imgURL)"
        self.name = "\(response.currency)"
        self.symbol = "\(response.ticker)"
        self.price = ""
    }
}
