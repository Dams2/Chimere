//
//  OrderDetailViewModel.swift
//  Chimere
//
//  Created by Damien Rojo on 30.04.20.
//  Copyright © 2020 Damien Rojo. All rights reserved.
//

import Foundation

final class OrderDetailViewModel {
    
    let order: UserOrders
    
    init(order: UserOrders) {
        self.order = order
    }

    // MARK: - Outputs
    
    var statusText: ((String) -> Void)?
    
    var originCurrencyImageText: ((String) -> Void)?
    
    var originAmountText: ((String) -> Void)?
    
    var originCurrencySymbolText: ((String) -> Void)?
    
    var toImageText: ((String) -> Void)?
    
    var destinationCurrencyImageText: ((String) -> Void)?
    
    var destinationAmountText: ((String) -> Void)?
    
    var destinationCurrencySymbolText: ((String) -> Void)?
    
    var dateText: ((String) -> Void)?
    
    
    // MARK: - Inputs
    
    func viewDidLoad() {
        statusText?("")
        originCurrencyImageText?("")
        originAmountText?(order.originAmount)
        originCurrencySymbolText?(order.originSymbol)
        toImageText?("")
        destinationCurrencyImageText?("")
        destinationAmountText?(order.destinationAmount)
        destinationCurrencySymbolText?(order.destinationSymbol)
        dateText?(order.createdDate)
    }
}
