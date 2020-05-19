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
    
    private let order: UserOrders
    
    private let translator: Translator

    init(order: UserOrders, translator: Translator) {
        self.order = order
        self.translator = translator
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
    
    var destinationAddressText: ((String) -> Void)?
    
    var destinationAddressValueText: ((String) -> Void)?
    
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
    
    var status: ((State) -> Void)?
    
    enum State {
        case failed
        case loaded
        case exchanging
        case completed
        case expired
        case notPaid
    }
    
    // MARK: - Inputs
    
    func viewDidLoad() {
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
        
        destinationAddressText?("Destination \(order.destinationSymbol) address")
        destinationAddressValueText?(order.destinationAddress)
        
        dateText?(order.createdDate)
        
        sendText?(translator.translate(key: "mobile/Exchange/originText"))
        depositAmountText?(order.originAmount)
        copyDepositAmountImageText?("square.on.square")
        
        toThisWalletText?(translator.translate(key: "mobile/Deposit/ToThisWalletText"))
        depositQRCodeImageText?(order.depositAddress)
        
        addressText?(translator.translate(key: "mobile/Deposit/AddressText"))
        depositAddressText?(order.depositAddress)
        copyDepositAdressImageText?("square.on.square")
        
        messageText?("")
        messageValueText?("")
        copyMessageValueImageText?("")
        
        guard order.state["Failed"] == false else {
            status?(.failed)
            statusText?("Failed")
            return
        }
        
        if order.state["Loaded"] == false && order.state["Exchanging"] == false && order.state["Completed"] == false {
            statusText?("Not paid")
            status?(.notPaid)
        } else {
            status?(.loaded)
            statusText?("Paid")
            if order.state["Completed"] == true {
                status?(.completed)
                statusText?("Completed")
            }
        }
        
        guard order.state["Expired"] == false else {
            status?(.expired)
            statusText?("Expired")
            return
        }
    }
}
