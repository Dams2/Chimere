//
//  HomeViewModel.swift
//  antex
//
//  Created by Damien Rojo on 14.04.20.
//  Copyright © 2020 Damien Rojo. All rights reserved.
//

import Foundation

final class ExchangeViewModel {
    
    // MARK: - Properties

    private weak var delegate: ExchangeViewControllerDelegate?
    
    private let repository: ExchangeRepositoryType

    init(delegate: ExchangeViewControllerDelegate?, repository: ExchangeRepositoryType) {
        self.delegate = delegate
        self.repository = repository
    }

    // MARK: - Outputs

    var descriptionText: ((String) -> Void)?
    
    // deposit

    var originText: ((String) -> Void)?
    
    var originAmountText: ((String) -> Void)?
    
    var originCurrencyNameText: ((String) -> Void)?
    
    var originCurrencySymbolText: ((String) -> Void)?
    
    var refundAddressText: ((String) -> Void)?
    
    // info
    
    var exchangeRatesText: ((String) -> Void)?

    // destination

    var destinationText: ((String) -> Void)?

    var destinationAmountText: ((String) -> Void)?

    var destinationCurrencyNameText: ((String) -> Void)?

    var destinationCurrencySymbolText: ((String) -> Void)?

    var destinationAddressText: ((String) -> Void)?
        
    // next step

    var exchangeNowText: ((String) -> Void)?
    
    var orderItems: [String: String] = [:]
    
    // MARK: - Inputs
    
    func viewDidLoad() {
        descriptionText?("We are making crypto easy to exchange")
        
        originText?("You send")
        originAmountText?("0.01")
        originCurrencyNameText?("Ethereum")
        originCurrencySymbolText?("ETH")
        refundAddressText?("Enter ETH refund address here... 👈")

        exchangeRatesText?("")

        destinationText?("You get approximately")
        destinationAmountText?("0.01")
        destinationCurrencyNameText?("Bitcoin")
        destinationCurrencySymbolText?("BTC")
        destinationAddressText?("Destination BTC address here... 👈")
        
        exchangeNowText?("Exchange Now")
    }
    
    func didPressChangeOriginCurrency() {
        delegate?.didShowOriginCurrenciesList()
    }
    
    func didPressSwitch() {
        
    }
    
    func didPressChangeDestinationCurrency() {
        delegate?.didShowDestinationCurrencies()
    }
    
    func didPressExchangeNow(originAmountText: String, originCurrencySymbolText: String, refundAddressText: String, destinationAmountText: String, destinationCurrencySymbolText: String, destinationAddressText: String) {
//        guard !refundAddressText.isEmpty else {
//            presentAlert(message: "You must fill refund address")
//            return
//        }
//
//        guard !destinationAddressText.isEmpty else {
//            presentAlert(message: "You must fill destination address")
//            return
//        }

//        repository.getAddressValidation(for: refundAddressText, symbol: depositCurrencySymbolText) { (validationDepositAdress) in
//            self.repository.getAddressValidation(for: destinationAddressText, symbol: destinationCurrencySymbolText) { (valisationDestinationAdress) in
//                self.addressValidation(validationDepositAdress: validationDepositAdress, valisationDestinationAdress: valisationDestinationAdress)
//            }
//        }
        
        orderItems = ["deposit_amount": originAmountText, "deposit_ticker": originCurrencySymbolText, "refund_address": refundAddressText, "destination_amount": "21", "destination_ticker": destinationCurrencySymbolText, "destination_address": destinationAddressText]

        self.delegate?.didSelectExchangeNow(orderItems: orderItems)
    }
    
    func updateOrigin(currency: Currency) {
        originCurrencyNameText?(currency.name)
        originCurrencySymbolText?(currency.symbol)
        refundAddressText?("Enter \(currency.symbol) refund address here... 👈")
        delegate?.didDismissCurrenciesList()
    }
    
    func updateDestination(currency: Currency) {
        destinationCurrencyNameText?(currency.name)
        destinationCurrencySymbolText?(currency.symbol)
        destinationAddressText?("Destination \(currency.symbol) address here... 👈")
        delegate?.didDismissCurrenciesList()
    }
    
    // MARK: - Helpers
    
    func getPrices(originAmountText: String, originCurrencySymbolText: String, destinationCurrencySymbolText: String) {
        repository.getPrices { (price) in
            guard let originRate = price.ask[originCurrencySymbolText]?.bestAsk,
                let destinationRate = price.bid[destinationCurrencySymbolText]?.bestBid
                else { return }
            
            self.exchangeRate(originAmountText: originAmountText, originRate: originRate, originCurrencySymbolText: originCurrencySymbolText, destinationRate: destinationRate, destinationCurrencySymbolText: destinationCurrencySymbolText)
        }
    }
    
    private func convertDestinationValue(originAmountText: String, rate: Float) {
        guard let originAmount = Float(originAmountText) else { return }
        if originAmount == 0 {
            destinationAmountText?("0")
        } else {
            let value = originAmount * rate
            destinationAmountText?("\(value)")
        }
    }
    
    private func exchangeRate(originAmountText: String, originRate: String, originCurrencySymbolText: String, destinationRate: String, destinationCurrencySymbolText: String) {
        guard let originRate = Float(originRate),
            let destinationRate = Float(destinationRate)
            else { return }
        
        let rate =  originRate / destinationRate
        
        self.convertDestinationValue(originAmountText: originAmountText, rate: rate)
        self.exchangeRatesText?("1 \(originCurrencySymbolText) ~ \(rate) \(destinationCurrencySymbolText)")
    }
    
    private func presentAlert(message: String) {
        DispatchQueue.main.async {
            self.delegate?.didPresentAlert(for: .badEntry(alertConfiguration: AlertConfiguration(title: "Warning", message: message, okMessage: "ok", cancelMessage: nil)))
        }
    }
    
    private func addressValidation(validationDepositAdress: Bool, valisationDestinationAdress: Bool) {
        if validationDepositAdress == false || valisationDestinationAdress == false {
            self.presentAlert(message: "Your refund address or your destination does not exist")
            return
        } else {
            DispatchQueue.main.async {
                self.delegate?.didSelectExchangeNow(orderItems: self.orderItems)
            }
        }
    }
}
