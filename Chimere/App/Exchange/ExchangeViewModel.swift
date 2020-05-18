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

    private let translator: Translator

    init(delegate: ExchangeViewControllerDelegate?, repository: ExchangeRepositoryType, translator: Translator) {
        self.delegate = delegate
        self.repository = repository
        self.translator = translator
    }

    var originCurrencyName: String = "" {
        didSet {
            originCurrencyNameText?(originCurrencyName)
        }
    }
    
    var originCurrencySymbol: String = "" {
        didSet {
            originCurrencySymbolText?(originCurrencySymbol)
        }
    }
    
    var destinationCurrencyName: String = "" {
        didSet {
            destinationCurrencyNameText?(destinationCurrencyName)
        }
    }
    
    var destinationCurrencySymbol: String = "" {
        didSet {
            destinationCurrencySymbolText?(destinationCurrencySymbol)
        }
    }
    
    var message: String = ""
    
    // MARK: - Outputs

    var descriptionText: ((String) -> Void)?

    // deposit

    var originText: ((String) -> Void)?

    var originAmountPlaceholderText: ((String) -> Void)?

    var originAmountText: ((String) -> Void)?

    var originCurrencyNameText: ((String) -> Void)?

    var originCurrencySymbolText: ((String) -> Void)?

    var refundAddressText: ((String) -> Void)?

    // info

    var exchangeRateText: ((String) -> Void)?

    // destination

    var destinationText: ((String) -> Void)?
    
    var destinationAmountPlaceholderText: ((String) -> Void)?

    var destinationAmountText: ((String) -> Void)?

    var destinationCurrencyNameText: ((String) -> Void)?

    var destinationCurrencySymbolText: ((String) -> Void)?

    var destinationAddressText: ((String) -> Void)?

    // Warning

    var warningImageText: ((String) -> Void)?

    var warningText: ((String) -> Void)?

    var warningAmountText: ((String) -> Void)?

    // next step

    var exchangeNowText: ((String) -> Void)?
    
    var alertState: ((Bool) -> Void)?

    var orderItems: [String: String] = [:]

    // MARK: - Inputs

    func viewDidLoad() {
        descriptionText?("We are making crypto easy to exchange")
//        descriptionText?(translator.translate(key: "mobile.chimere/exchange/description.text"))

        originText?("You send")
        originAmountPlaceholderText?("0.01")
        originAmountText?("")
        originCurrencyName = "Ethereum"
        originCurrencySymbol = "ETH"
        refundAddressText?("Enter ETH refund address here... 👈")

        exchangeRateText?("")

        destinationText?("You get approximately")
        destinationAmountPlaceholderText?("0.01")
        destinationAmountText?("")
        destinationCurrencyName = "Bitcoin"
        destinationCurrencySymbol = "BTC"
        destinationAddressText?("Destination BTC address here... 👈")

        warningImageText?("")
        warningText?("")
        warningAmountText?("")

        exchangeNowText?("Exchange Now")
        
        alertState?(true)
    }

    func didPressChangeOriginCurrency() {
        delegate?.didShowOriginCurrenciesList()
    }

    func didPressSwitch(originAmountText: String) {
        switchCurrencies()
        message = "\(destinationCurrencySymbol)/\(originCurrencySymbol)"
        getPrices(originAmountText: originAmountText)
    }

    func didPressChangeDestinationCurrency() {
        delegate?.didShowDestinationCurrencies()
    }

    func didPressWarningAmount(warningAmountText: String,
                               originAmount: String) {
        originAmountText?("\(warningAmountText)")
        getPrices(originAmountText: warningAmountText)
        alertState?(true)
    }

    func didPressExchangeNow(userID: String,
                             originAmountText: String,
                             refundAddressText: String,
                             destinationAmountText: String,
                             destinationAddressText: String,
                             exchangeRate: String) {
        
        guard originCurrencySymbol != destinationCurrencySymbol else {
            presentAlert(message: "You can't exchange \(originCurrencySymbol) to \(destinationCurrencySymbol)")
            return
        }
        
        guard !originAmountText.isEmpty else {
            presentAlert(message: "You must fill in  an amount")
            return
        }
        
        guard destinationAmountText != "..." else { return }
        print("---- \(destinationAmountText)")

        guard !refundAddressText.isEmpty else {
            presentAlert(message: "You must fill refund address")
            return
        }

        guard !destinationAddressText.isEmpty else {
            presentAlert(message: "You must fill destination address")
            return
        }
        
        orderItems = ["owner": userID,
                      "deposit_amount": originAmountText,
                      "deposit_ticker": originCurrencySymbol,
                      "refund_address": refundAddressText,
                      "destination_amount": destinationAmountText,
                      "destination_ticker": destinationCurrencySymbol,
                      "destination_address": destinationAddressText,
                      "exchangeRate": exchangeRate]
        
//        repository.getAddressValidation(for: refundAddressText, symbol: originCurrencySymbolText) { (validationDepositAdress) in
//            self.repository.getAddressValidation(for: destinationAddressText, symbol: destinationCurrencySymbolText) { (valisationDestinationAdress) in
//                self.addressValidation(validationDepositAdress: validationDepositAdress, valisationDestinationAdress: valisationDestinationAdress)
//            }
//        }

        self.delegate?.didSelectExchangeNow(orderItems: orderItems)
    }

    func updateOrigin(currency: Currency, originAmountText: String) {
        getPrices(originAmountText: originAmountText)
        originCurrencyNameText?(currency.name)
        originCurrencySymbol = currency.symbol
        refundAddressText?("Enter \(currency.symbol) refund address here... 👈")
        delegate?.didDismissCurrenciesList()
        getPrices(originAmountText: originAmountText)
    }

    func updateDestination(currency: Currency, originAmountText: String) {
        guard currency.name != originAmountText else { return }
        destinationCurrencyNameText?(currency.name)
        destinationCurrencySymbol = currency.symbol
        destinationAddressText?("Destination \(currency.symbol) address here... 👈")
        delegate?.didDismissCurrenciesList()
        getPrices(originAmountText: originAmountText)
    }

    // MARK: - Helpers

    func getPrices(originAmountText: String) {
        destinationAmountText?("...")
        message = "\(originCurrencySymbol)/\(destinationCurrencySymbol)"
        print(message)
        repository.getPrices(message: message) { (price) in
            guard let destinationRate = price.askPrice.bestAsk,
                let originRate = price.bidPrice.bestBid
                else { return }
            
            self.exchangeRateValue(originAmountText: originAmountText,
                                   originRate: originRate,
                                   destinationRate: destinationRate,
                                   maximumPrice: price.askMax,
                                   minimumPrice: price.askMin)
        }
    }

    private func exchangeRateValue(originAmountText: String,
                                   originRate: String,
                                   destinationRate: String,
                                   maximumPrice: String,
                                   minimumPrice: String) {
        guard let originRate = Float(originRate),
            let destinationRate = Float(destinationRate)
            else { return }

        let rate =  originRate / destinationRate

        self.convertDestinationValue(originAmountText: originAmountText,
                                     rate: rate,
                                     maximumPrice: maximumPrice,
                                     minimumPrice: minimumPrice)
        self.exchangeRateText?("1 \(originCurrencySymbol) ~ \(rate) \(destinationCurrencySymbol)")
    }

    private func convertDestinationValue(originAmountText: String,
                                         rate: Float,
                                         maximumPrice: String,
                                         minimumPrice: String) {
        guard let originAmount = Float(originAmountText),
            let maximumPrice = Float(maximumPrice),
            let minimumPrice = Float(minimumPrice)
            else { return }
        
        let maximumAmount = maximumPrice / rate
        let minimumAmount = minimumPrice / rate

        guard originAmount >= minimumAmount else {
            warningSettings(destinationAmount: "...",
                            image: "exclamationmark.triangle",
                            message: "Minimum amount is:",
                            warningAmount: "\(minimumAmount)")
            alertState?(false)
            return
        }
        
        guard originAmount <= maximumAmount else {
            warningSettings(destinationAmount: "...",
                            image: "exclamationmark.triangle",
                            message: "Maximum amount is:",
                            warningAmount: "\(maximumAmount)")
            alertState?(false)
            return
        }

        let value = originAmount * rate
        let formatValue = String(format: "%.10f", value)
        warningSettings(destinationAmount: formatValue, image: "", message: "", warningAmount: "")
    }
    
    private func warningSettings(destinationAmount: String, image: String, message: String, warningAmount: String) {
        destinationAmountText?(destinationAmount)
        warningImageText?(image)
        warningText?(message)
        warningAmountText?("\(warningAmount)")
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
    
    private func switchCurrencies() {
        let origin = [originCurrencyName, originCurrencySymbol]
        let destination = [destinationCurrencyName, destinationCurrencySymbol]

        DispatchQueue.main.async {
            self.exchangeRateText?("")
            self.originCurrencyName = destination[0]
            self.originCurrencySymbol = destination[1]
            self.refundAddressText?("Enter \(destination[1]) refund address here... 👈")

            self.destinationCurrencyName = origin[0]
            self.destinationCurrencySymbol = origin[1]
            self.destinationAddressText?("Destination \(origin[1]) address here... 👈")
        }
    }
}
