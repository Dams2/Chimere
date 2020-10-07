//
//  HomeViewModel.swift
//  antex
//
//  Created by Damien Rojo on 14.04.20.
//  Copyright © 2020 Damien Rojo. All rights reserved.
//

import Foundation

final class ExchangeViewModel {

    // MARK: - Private Properties

    private let repository: ExchangeRepositoryType
    private let translator: Translator

    private var originCurrencyName: String = "" {
        didSet {
            originCurrencyNameText?(originCurrencyName)
        }
    }

    private var originCurrencySymbol: String = "" {
        didSet {
            originCurrencySymbolText?(originCurrencySymbol)
        }
    }

    private var destinationCurrencyName: String = "" {
        didSet {
            destinationCurrencyNameText?(destinationCurrencyName)
        }
    }

    private var destinationCurrencySymbol: String = "" {
        didSet {
            destinationCurrencySymbolText?(destinationCurrencySymbol)
        }
    }

    private var message: String = ""
    private var orderItems: [String: String] = [:]
    private let actions: Actions
    
    struct Actions {
        let didPresentExchange: VoidClosure
        let didSelectBoard: VoidClosure
        let didSelectHowItWork: VoidClosure
        let didSelectOriginCurrency: VoidClosure
        let didSelectDestinationCurrency: VoidClosure
        let didDismissCurrenciesList: VoidClosure
        let didSelectExchangeNow: ([String: String]) -> Void
        let didPresentAlert: (AlertConfiguration) -> Void
        
    }

    // MARK: - Init

    init(
        actions: Actions,
        repository: ExchangeRepositoryType,
        translator: Translator
    ) {
        self.actions = actions
        self.repository = repository
        self.translator = translator
    }
    
    // MARK: - Outputs
    
    var scanText: InputClosure<String>?
    var descriptionText: InputClosure<String>?

    // deposit

    var originText: InputClosure<String>?
    var originAmountPlaceholderText: InputClosure<String>?
    var originAmountText: InputClosure<String>?
    var originCurrencyNameText: InputClosure<String>?
    var originCurrencySymbolText: InputClosure<String>?
    var refundAddressText: InputClosure<String>?

    // info

    var exchangeRateText: InputClosure<String>?

    // destination

    var destinationText: InputClosure<String>?
    var destinationAmountText: InputClosure<String>?
    var destinationCurrencyNameText: InputClosure<String>?
    var destinationCurrencySymbolText: InputClosure<String>?
    var destinationAddressText: InputClosure<String>?
    var scanQRCodeImageText: InputClosure<String>?

    // Warning

    var warningImageText: InputClosure<String>?
    var warningText: InputClosure<String>?
    var warningAmountText: InputClosure<String>?

    // next step

    var exchangeNowText: InputClosure<String>?
    var alertState: InputClosure<Bool>?
    var loadingState: InputClosure<Bool>?

    // MARK: - Inputs

    func viewDidLoad() {
        scanText?(translator.translate(key: "mobile/Annex/ScanText"))
        
        descriptionText?(translator.translate(key: "mobile/Exchange/descriptionText"))

        originText?(translator.translate(key: "mobile/Exchange/originText"))
        originAmountPlaceholderText?("0.01")
        originAmountText?("")
        originCurrencyName = "Ethereum"
        originCurrencySymbol = "ETH"
        refundAddressText?(translator.translate(key: "mobile/Exchange/refundAddressText"))

        exchangeRateText?("")

        destinationText?(translator.translate(key: "mobile/Exchange/destinationText"))
        destinationAmountText?("...")
        destinationCurrencyName = "Chainlink"
        destinationCurrencySymbol = "LINK"
        destinationAddressText?(translator.translate(key: "mobile/Exchange/destinationAddressText"))
        scanQRCodeImageText?("qrcode.viewfinder")

        warningImageText?("")
        warningText?("")
        warningAmountText?("")

        exchangeNowText?(translator.translate(key: "mobile/Exchange/exchangeNowText"))
        
        alertState?(true)
    }
    
    func didPressBoard() {
        actions.didSelectBoard()
    }
    
    func didPressHowItWork() {
        actions.didSelectHowItWork()
    }

    func didPressOriginCurrency() {
        actions.didSelectOriginCurrency()
    }

    func didPressSwitch(originAmountText: String) {
        switchCurrencies()
        message = "\(destinationCurrencySymbol)/\(originCurrencySymbol)"
        getPrices(originAmountText: originAmountText, message: message)
    }

    func didPressDestinationCurrency() {
        actions.didSelectDestinationCurrency()
    }

    func didPressWarningAmount(warningAmountText: String,
                               originAmount: String) {
        originAmountText?("\(warningAmountText)")
        getPrices(originAmountText: warningAmountText, message: message)
        alertState?(true)
    }

    func didPressExchangeNow(userID: String,
                             originAmountText: String,
                             refundAddressText: String,
                             destinationAmountText: String,
                             destinationAddressText: String,
                             exchangeRate: String) {
        
        guard originCurrencySymbol != destinationCurrencySymbol else {
            presentAlert(message: "\(translator.translate(key: "mobile/Annex/SameCurrency")) \(originCurrencySymbol) \(translator.translate(key: "mobile/Annex/to")) \(destinationCurrencySymbol)")
            return
        }
        
        guard !originAmountText.isEmpty else {
            presentAlert(message: translator.translate(key: "mobile/Exchange/Alert/fillAnAmount"))
            return
        }
        
        guard destinationAmountText != "..." else { return }

        guard !destinationAddressText.isEmpty else {
            presentAlert(message: translator.translate(key: "mobile/Exchange/Alert/fillDestinationAddress"))
            return
        }
        
        orderItems = ["owner": userID,
                      "deposit_amount": originAmountText,
                      "deposit_ticker": originCurrencySymbol,
                      "refund_address": "refundAddressText",
                      "destination_amount": destinationAmountText,
                      "destination_ticker": destinationCurrencySymbol,
                      "destination_address": destinationAddressText,
                      "exchangeRate": exchangeRate]
        
        let address = ["address": destinationAddressText, "chain": destinationCurrencySymbol]
        
        repository.getAddressValidation(address: address) { (validation) in
            self.addressValidation(valisationDestinationAdress: validation.valid, orderItems: self.orderItems)
        }
    }

    func updateOrigin(currency: Currency, originAmountText: String) {
        originCurrencyName = currency.name
        originCurrencySymbol = currency.symbol
        actions.didDismissCurrenciesList()
        message = "\(originCurrencySymbol)/\(destinationCurrencySymbol)"
        getPrices(originAmountText: originAmountText, message: message)
    }

    func updateDestination(currency: Currency, originAmountText: String) {
        guard currency.name != originAmountText else { return }
        destinationCurrencyName = currency.name
        destinationCurrencySymbol = currency.symbol
        destinationAddressText?("\(translator.translate(key: "mobile/Annex/Enter")) \(currency.symbol) \(translator.translate(key: "mobile/Annex/AddressHere"))")
        actions.didDismissCurrenciesList()
        message = "\(originCurrencySymbol)/\(destinationCurrencySymbol)"
        getPrices(originAmountText: originAmountText, message: message)
    }
    
    func getRates(originAmountText: String) {
        message = "\(originCurrencySymbol)/\(destinationCurrencySymbol)"
        getPrices(originAmountText: originAmountText, message: message)
    }
    // MARK: - Helpers

    private func getPrices(originAmountText: String, message: String) {
        loadingState?(true)
        destinationAmountText?("...")
        repository.getPrices(message: message) { (price) in
            guard let destinationRate = price.askPrice.bestAsk,
                let originRate = price.bidPrice.bestBid
                else { return }
            print(price)
            self.loadingState?(false)
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
        let formatValue = String(format: "%.8f", rate)

        self.convertDestinationValue(originAmountText: originAmountText,
                                     rate: rate,
                                     maximumPrice: maximumPrice,
                                     minimumPrice: minimumPrice)
        self.exchangeRateText?("1 \(originCurrencySymbol) ~ \(formatValue) \(destinationCurrencySymbol)")
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
                            message: translator.translate(key: "mobile/Exchange/WarningMinimumAmount"),
                            warningAmount: "\(minimumAmount)")
            alertState?(false)
            return
        }
        
        guard originAmount <= maximumAmount else {
            warningSettings(destinationAmount: "...",
                            image: "exclamationmark.triangle",
                            message: translator.translate(key: "mobile/Exchange/WarningMaximumAmount"),
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
            self.actions.didPresentAlert(AlertConfiguration(title: self.translator.translate(key: "mobile/Exchange/Alert/title"), message: message, okMessage: self.translator.translate(key: "mobile/Exchange/Alert/OkMessage"), cancelMessage: nil))
        }
    }

    private func addressValidation(valisationDestinationAdress: Bool, orderItems: [String: String]) {
        if valisationDestinationAdress == false {
            self.presentAlert(message: translator.translate(key: "mobile/Exchange/Alert/AddressDoNotExist"))
            return
        } else {
            DispatchQueue.main.async {
                self.actions.didSelectExchangeNow(orderItems)
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

            self.destinationCurrencyName = origin[0]
            self.destinationCurrencySymbol = origin[1]
            self.destinationAddressText?("\(self.translator.translate(key: "mobile/Annex/Enter" )) \(origin[1]) \(self.translator.translate(key: "mobile/Annex/AddressHere"))")
        }
    }
}
