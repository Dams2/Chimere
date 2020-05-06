//
//  OrderDetailViewModel.swift
//  Chimere
//
//  Created by Damien Rojo on 30.04.20.
//  Copyright © 2020 Damien Rojo. All rights reserved.
//

import Foundation

final class OrderDetailViewModel {
    
    // MARK: - Properties
    
    let order: UserOrders

    init(order: UserOrders) {
        self.order = order
    }

    // MARK: - Outputs
    
    var statusText: ((String) -> Void)?
    
    var transactionIDText: ((String) -> Void)?
    
    var transactionIDValueText: ((String) -> Void)?
    
    var copyTansactionIDImageText: ((String) -> Void)?
    
    var originCurrencyImageText: ((String) -> Void)?
    
    var originAmountText: ((String) -> Void)?
    
    var originCurrencySymbolText: ((String) -> Void)?
    
    var toImageText: ((String) -> Void)?
    
    var destinationCurrencyImageText: ((String) -> Void)?
    
    var destinationAmountText: ((String) -> Void)?
    
    var destinationCurrencySymbolText: ((String) -> Void)?
    
    var dateText: ((String) -> Void)?
    
    // Wallet
    
    var sendText: ((String) -> Void)?
    
    var depositAmountText: ((String) -> Void)?
    
    var copyDepositAmountImageText: ((String) -> Void)?
    
    var toThisWalletText: ((String) -> Void)?
    
    var depositQRCodeImageText: ((String) -> Void)?
    
    var addressText: ((String) -> Void)?
    
    var depositAddressText: ((String) -> Void)?
    
    var copyDepositAdressImageText:((String) -> Void)?
    
    var messageText: ((String) -> Void)?
    
    var messageValueText: ((String) -> Void)?
    
    var copyMessageValueImageText: ((String) -> Void)?
    
    // MARK: - Inputs
    
    func viewDidLoad() {
        for (state, value) in order.state {
            if value == true {
                self.statusText?(state)
            }
        }
        transactionIDText?("Transaction ID:")
        transactionIDValueText?(order.id)
        copyTansactionIDImageText?("square.on.square")
        originCurrencyImageText?(order.originSymbol)
        originAmountText?(order.originAmount)
        originCurrencySymbolText?(order.originSymbol)
        toImageText?("chevron.down")
        destinationCurrencyImageText?(order.destinationSymbol)
        destinationAmountText?(order.destinationAmount)
        destinationCurrencySymbolText?(order.destinationSymbol)
        dateText?(order.createdDate)
        
        sendText?("Send")
        depositAmountText?(order.originAmount)
        copyDepositAmountImageText?("square.on.square")
        
        toThisWalletText?("To this wallet")
        depositQRCodeImageText?("")
        
        addressText?("Address")
        depositAddressText?("")
        copyDepositAdressImageText?("square.on.square")
        
        messageText?("")
        messageValueText?("")
        copyMessageValueImageText?("")
    }
}
