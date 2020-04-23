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
    
    private let deposit: Deposit
    
    private let repository: ExchangeRepositoryType

    init(deposit: Deposit, repository: ExchangeRepositoryType) {
        self.deposit = deposit
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
        transactionIDValueText?(deposit.id)
        copyTansactionIDImageText?("square.on.square")
        
        descriptionText?("Please use your wallet or exchange account to send money to the following address by typing it in or scanning the QR code")
        
        sendText?("Send")
        depositAmountText?("\(deposit.depositAmount)")
        copyDepositAmountImageText?("square.on.square")
        
        toThisWalletText?("To this address")
        depositQRCodeText?(deposit.depositAddress)
        
        addressText?("Address")
        depositAddressText?(deposit.depositAddress)
        copyDepositAdressImageText?("square.on.square")
        
        messageText?("Message")
        copyMessageValueImageText?("square.on.square")
    }
}
