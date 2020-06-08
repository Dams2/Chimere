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
    
    var statusStep1Text: ((String) -> Void)?
    
    var statusStep1ImageText: ((String) -> Void)?
    
    var statusStep2Text: ((String) -> Void)?
    
    var statusStep2ImageText: ((String) -> Void)?
    
    var statusStep3Text: ((String) -> Void)?
    
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
        statusStep1Text?(translator.translate(key: "mobile/History/paid"))
        statusStep1ImageText?("arrow.right")
        statusStep2Text?(translator.translate(key: "mobile/History/exchanging"))
        statusStep2ImageText?("arrow.right")
        statusStep3Text?(translator.translate(key: "mobile/History/completed"))
        
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
        
            
        messageValueText?("")
        copyMessageValueImageText?("")
        
        guard order.state["Failed"] == false else {
            status?(.failed)
            statusText?(translator.translate(key: "mobile/History/failed"))
            return
        }
        
        if order.state["Loaded"] == false {
            statusText?(translator.translate(key: "mobile/History/notPaid"))
            status?(.notPaid)
        }
        
        if order.state["Loaded"] == true {
            status?(.loaded)
            statusStep1ImageText?("minus")
        }
        
        if order.state["Exchanging"] == true {
            status?(.exchanging)
            statusStep2ImageText?("minus")
        }
        
        if order.state["Completed"] == true {
            status?(.completed)
        }
        
        guard order.state["Expired"] == false else {
            status?(.expired)
            statusText?(translator.translate(key: "mobile/History/expired"))
            return
        }
    }
}
