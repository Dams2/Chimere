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
    
    private let delegate: ExchangeViewControllerDelegate
    
    private let translator: Translator

    init(deposit: Deposit, repository: ExchangeRepositoryType, delegate: ExchangeViewControllerDelegate, translator: Translator) {
        self.deposit = deposit
        self.repository = repository
        self.delegate = delegate
        self.translator = translator
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
    
    var completedText: ((String) -> Void)?

    // MARK: - Inputs
    
    func viewDidLoad() {
        transactionIDText?("Transaction ID:")
        transactionIDValueText?(deposit.id)
        copyTansactionIDImageText?("square.on.square")
        
        descriptionText?(translator.translate(key: "mobile/Deposit/DescriptionText"))
        
        sendText?(translator.translate(key: "mobile/Exchange/originText"))
        depositAmountText?("\(deposit.depositAmount) \(deposit.depositSymbol)")
        copyDepositAmountImageText?("square.on.square")
        
        toThisWalletText?(translator.translate(key: "mobile/Deposit/ToThisWalletText"))
        depositQRCodeText?(deposit.depositAddress)
        
        addressText?(translator.translate(key: "mobile/Deposit/AddressText"))
        depositAddressText?(deposit.depositAddress)
        copyDepositAdressImageText?("square.on.square")
        
        messageText?("Message")
        copyMessageValueImageText?("square.on.square")
        
        completedText?(translator.translate(key: "mobile/Deposit/CompletedText"))
        print("xxxxxxxxxxx\(deposit.createdDate)")
    }
    
    func didPressCompleted() {
        delegate.didshowExchange()
    }
}
