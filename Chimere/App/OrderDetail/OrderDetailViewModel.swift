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

    // State
    
    var paidImageText: ((String) -> Void)?

    var paidText: ((String) -> Void)?
    
    var exchangingImageText: ((String) -> Void)?

    var exchangingText: ((String) -> Void)?

    var exchangedImageText: ((String) -> Void)?
    
    var exchangedText: ((String) -> Void)?
    
    var sendingImageText: ((String) -> Void)?

    var sendingText: ((String) -> Void)?

    var completedImageText: ((String) -> Void)?

    var completedText: ((String) -> Void)?

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
        case exchanged
        case sending
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
        
        destinationAddressText?("\(translator.translate(key: "mobile/Annex/Destination")) \(order.destinationSymbol) \(translator.translate(key: "mobile/Annex/Address"))")
        destinationAddressValueText?(order.destinationAddress)
        
        dateText?(order.createdDate)
        
        // State
        
        paidImageText?("checkmark.seal")

        paidText?(translator.translate(key: "mobile/History/paid"))
        
        exchangingImageText?("checkmark.seal")

        exchangingText?(translator.translate(key: "mobile/History/exchanging"))

        exchangedImageText?("checkmark.seal")
        
        exchangedText?(translator.translate(key: "mobile/History/exchanged"))
        
        sendingImageText?("checkmark.seal")

        sendingText?(translator.translate(key: "mobile/History/sending"))

        completedImageText?("checkmark.seal")

        completedText?(translator.translate(key: "mobile/History/completed"))
        
        // wallet
        
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
            statusText?(translator.translate(key: "mobile/History/paid"))
            status?(.loaded)
        }
        
        if order.state["Exchanging"] == true {
            statusText?(translator.translate(key: "mobile/History/exchanging"))
            status?(.exchanging)
        }
        
        if order.state["Exchanged"] == true {
            statusText?(translator.translate(key: "mobile/History/exchanged"))
            status?(.exchanged)
        }
        
        if order.state["Sending"] == true {
            statusText?(translator.translate(key: "mobile/History/sending"))
            status?(.sending)
        }
        
        if order.state["Completed"] == true {
            statusText?(translator.translate(key: "mobile/History/completed"))
            status?(.completed)
        }
        
        guard order.state["Expired"] == false else {
            status?(.expired)
            statusText?(translator.translate(key: "mobile/History/expired"))
            return
        }
    }
}
