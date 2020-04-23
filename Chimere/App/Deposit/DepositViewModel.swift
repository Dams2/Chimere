//
//  Step2ViewModel.swift
//  antex
//
//  Created by Damien Rojo on 15.04.20.
//  Copyright © 2020 Damien Rojo. All rights reserved.
//

import Foundation

final class DepositViewModel {
    
    // MARK: - Private Properties
    
    private let repository: ExchangeRepositoryType

    init(repository: ExchangeRepositoryType) {
        self.repository = repository
    }
    
    // MARK: - Outputs
    
    var transactionIDText: ((String) -> Void)?
    
    var transactionIDValueText: ((String) -> Void)?
    
    var copyTansactionIDImageText: ((String) -> Void)?
    
    var descriptionText: ((String) -> Void)?
    
    var sendText: ((String) -> Void)?

    var depositAmountText: ((String) -> Void)?
    
    var copyDepositAmountImageText: ((String) -> Void)?
    
    var toThisWalletText: ((String) -> Void)?
    
    var depositQRCodeText: ((String) -> Void)?
    
    var addressText: ((String) -> Void)?
    
    var depositAddressText: ((String) -> Void)?

    var copyDepositAdressImageText: ((String) -> Void)?
    
    var messageText: ((String) -> Void)?

    var messageValueText: ((String) -> Void)?
    
    var copyMessageValueImageText: ((String) -> Void)?

    // MARK: - Inputs
    
    func viewDidLoad() {
        transactionIDText?("Trasaction ID:")
        copyTansactionIDImageText?("square.on.square")
        
        descriptionText?("Please use your wallet or exchange account to send money to the following address by typing it in or scanning the QR code")
        
        sendText?("Send")
        copyDepositAmountImageText?("square.on.square")
        
        toThisWalletText?("To this address")
        
        addressText?("Address")
        copyDepositAdressImageText?("square.on.square")
        
        messageText?("Message")
        copyMessageValueImageText?("square.on.square")
    }
    
    func depositRequest() {
        let orderItems: [String: Any] = ["deposit_amount": "120", "deposit_ticker": "ETH", "refund_address": "0xa2fec727757e47c64942e23949da839e6da948ac", "destination_amount": "34", "destination_ticker": "BTC", "destination_address": "18cBEMRxXHqzWWCxZNtU91F5sbUNKhL5PX"]
               
        repository.postOrder(order: orderItems) { (depositResponse) in
           guard let id =  depositResponse.order.id else {return}
            
           self.transactionIDValueText?(id)
           self.depositAmountText?("\(depositResponse.order.depositAmount)")
           self.depositQRCodeText?(depositResponse.order.depositAddress)
           self.depositAddressText?(depositResponse.order.depositAddress)
            
        }
    }
}
