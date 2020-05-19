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
    
    private let translator: Translator

    init(orderItems: [String: String], delegate: OrderSummaryViewControllerDelegate?, repository: ExchangeRepositoryType, translator: Translator) {
        self.orderItems = orderItems
        self.delegate = delegate
        self.repository = repository
        self.translator = translator
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
    var exchangeFeeAmountText: ((String) -> Void)?
    
    var arrivalTimeText: ((String) -> Void)?
    var estimatedTimeArrival: ((String) -> Void)?
    
    var termsOfUseText: ((String) -> Void)?
    var showTermsOfUse: ((String) -> Void)?
    
    var confirmText: ((String) -> Void)?

    var loadingState: ((Bool) -> Void)?

    // MARK: - Inputs
    
    func viewDidLoad() {
        orderText?(translator.translate(key: "mobile/OrderSummary/OrderText"))

        originText?(translator.translate(key: "mobile/Exchange/originText"))
        
        destinationText?(translator.translate(key: "mobile/Exchange/destinationText"))

        exchangeRateText?(translator.translate(key: "mobile/OrderSummary/ExchangeRateText"))

        exchangeFeeText?(translator.translate(key: "mobile/OrderSummary/ExchangeFee"))
        exchangeFeeAmountText?("0.09")

        arrivalTimeText?(translator.translate(key: "mobile/OrderSummary/ArrivalTimeText"))
        estimatedTimeArrival?("5 - 30 min")
        
        termsOfUseText?(translator.translate(key: "mobile/OrderSummary/TermsOfUseText"))
        showTermsOfUse?(translator.translate(key: "mobile/OrderSummary/ShowTermsOfUse"))

        confirmText?(translator.translate(key: "mobile/OrderSummary/ConfirmText"))

        setOrder()
    }
    
    func didPressTermsOfUse() -> String {
        let stringUrl = "https://chimere.io/terms-of-use"
        return stringUrl
    }

    func postOrder()  {
        loadingState?(true)
        repository.postOrder(order: orderItems) { [weak self] (depositResponse) in
            self?.loadingState?(false)
            self?.deposit = Deposit(response: depositResponse)
        }
    }
    
    func didPressConfirm() {
        guard let deposit = deposit else { return }
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
