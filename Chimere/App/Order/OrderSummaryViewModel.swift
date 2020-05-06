//
//  OrderSummaryViewModel.swift
//  Chimere
//
//  Created by Damien Rojo on 23.04.20.
//  Copyright © 2020 Damien Rojo. All rights reserved.
//

import Foundation

final class OrderSummaryViewModel {
    
    private let orderItems: [String: String]
    
    private let delegate: OrderSummaryViewControllerDelegate?
    
    private let repository: ExchangeRepositoryType

    private var deposit: Deposit?

    init(orderItems: [String: String], delegate: OrderSummaryViewControllerDelegate?, repository: ExchangeRepositoryType) {
        self.orderItems = orderItems
        self.delegate = delegate
        self.repository = repository
    }
    
    // MARK: - Outputs
    
    var orderText: ((String) -> Void)?
    var originText:((String) -> Void)?
    var originAmountText: ((String) -> Void)?
    
    var destinationText: ((String) -> Void)?
    var destinationAmountText: ((String) -> Void)?
    
    var destinationAddressText: ((String) -> Void)?
    var destinationTokenAddressText : ((String) -> Void)?
    
    var exchangeRateText: ((String) -> Void)?
    var exchangeRatesAmountText: ((String) -> Void)?
    
    var exchangeFeeText: ((String) -> Void)?
    var totalFeeAmountText: ((String) -> Void)?
    
    var arrivalTimeText: ((String) -> Void)?
    var estimatedTimeArrival: ((String) -> Void)?
    
    var confirmText: ((String) -> Void)?

    // MARK: - Inputs
    
    func viewDidLoad() {
        orderText?("Order")

        originText?("You send")

        destinationText?("You get approximately")

        exchangeRateText?("Exchange rates")
        exchangeFeeText?("0.09")
        
        arrivalTimeText?("Arrival time")
        estimatedTimeArrival?("5 - 30 min")

        confirmText?("Confirm")

        setOrder()

        repository.postOrder(order: orderItems) { (depositResponse) in
            self.deposit = Deposit(response: depositResponse)
        }
    }

    func didPressConfirm() {
        guard let deposit = self.deposit else { return }
        delegate?.didSelectConfirm(deposit: deposit)
    }
    
    // MARK: - Helpers
    
    private func setOrder() {
        guard let originAmount = self.orderItems["deposit_amount"],
            let originCurrencySymbolText = self.orderItems["deposit_ticker"],
            let destinationAmountText = self.orderItems["destination_amount"],
            let destinationCurrencySymbolText = self.orderItems["destination_ticker"],
            let destinationTokenAddressText = self.orderItems["destination_address"],
            let exchangeRateText = self.orderItems["exchangeRate"]
            else { return }
        
        self.originAmountText?("\(originAmount) \(originCurrencySymbolText)")
        self.destinationAmountText?("\(destinationAmountText) \(destinationCurrencySymbolText)")
        self.destinationTokenAddressText?(destinationTokenAddressText)
        self.exchangeRatesAmountText?("\(exchangeRateText)")
    }
}
