//
//  ExchangeViewModelTests.swift
//  ChimereTests
//
//  Created by Damien Rojo on 24.09.20.
//  Copyright © 2020 Damien Rojo. All rights reserved.
//

import XCTest
@testable import Chimere

final class ExchangeViewModelTests: XCTestCase {

    private var repository: MockExchangeRepository!
    private var translator: Translator!
    private var viewModel: ExchangeViewModel!

    override func setUp() {
        super.setUp()
        repository = MockExchangeRepository()
        translator = Translator(with: "Fr")
        viewModel = ExchangeViewModel(
            actions: .init(
                didPresentExchange: {
                    
            },
                didSelectBoard: {
                    
            },
                didSelectHowItWork: {
                    
            },
                didSelectOriginCurrency: {
                   
            },
                didSelectDestinationCurrency: {
                    
            },
                didDismissCurrenciesList: {
                   
            },
                didSelectExchangeNow: { _ in
                
            },
                didPresentAlert: { _ in
                
            }),
            repository: repository,
            translator: translator
        )
    }
    
    func testGivenExchangeViewModel_WhenViewDidLoad_ThenScanText_IsCorrectlyReturned() {
        let expectation = self.expectation(description: "Scan text returned")
        
        viewModel.scanText = { text in
            XCTAssertEqual(text, self.translator.translate(key: "mobile/Annex/ScanText"))
            expectation.fulfill()
        }
        
        viewModel.viewDidLoad()
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testGivenExchangeViewModel_WhenViewDidLoad_ThenDescriptionText_IsCorrectlyReturned() {

        let expectation = self.expectation(description: "Desciption text returned")
        
        viewModel.descriptionText = { text in
            XCTAssertEqual(text, self.translator.translate(key: "mobile/Exchange/descriptionText"))
            expectation.fulfill()
        }
        
        viewModel.viewDidLoad()
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testGivenExchangeViewModel_WhenViewDidLoad_ThenOriginText_IsCorrectlyReturned() {
        let expectation = self.expectation(description: "Origin text returned")
        
        viewModel.originText = { text in
            XCTAssertEqual(text, self.translator.translate(key: "mobile/Exchange/originText"))
            expectation.fulfill()
        }
        
        viewModel.viewDidLoad()
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testGivenExchangeViewModel_WhenViewDidLoad_ThenOriginAmountPlaceholderText_IsCorrectlyReturned() {
        let expectation = self.expectation(description: "Origin Amount Placeholder text returned")
        
        viewModel.originAmountPlaceholderText = { text in
            XCTAssertEqual(text, "0.01")
            expectation.fulfill()
        }
        
        viewModel.viewDidLoad()
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testGivenExchangeViewModel_WhenViewDidLoad_ThenOriginAmountText_IsCorrectlyReturned() {
        let expectation = self.expectation(description: "Origin Amount text returned")
        
        viewModel.originAmountText = { text in
            XCTAssertEqual(text, "")
            expectation.fulfill()
        }
        
        viewModel.viewDidLoad()
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testGivenExchangeViewModel_WhenViewDidLoad_ThenOriginCurrencyNameText_IsCorrectlyReturned() {
        let expectation = self.expectation(description: "Origin Currency Name text returned")
        
        viewModel.originCurrencyNameText = { text in
            XCTAssertEqual(text, "Ethereum")
            expectation.fulfill()
        }
        
        viewModel.viewDidLoad()
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testGivenExchangeViewModel_WhenViewDidLoad_ThenOriginCurrencySymbolText_IsCorrectlyReturned() {
        let expectation = self.expectation(description: "Origin Currency Symbol text returned")
        
        viewModel.originCurrencySymbolText = { text in
            XCTAssertEqual(text, "ETH")
            expectation.fulfill()
        }
        
        viewModel.viewDidLoad()
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testGivenExchangeViewModel_WhenViewDidLoad_ThenRefundAddressText_IsCorrectlyReturned() {
        let expectation = self.expectation(description: "Refund Address text returned")
        
        viewModel.refundAddressText = { text in
            XCTAssertEqual(text, self.translator.translate(key: "mobile/Exchange/refundAddressText"))
            expectation.fulfill()
        }
        
        viewModel.viewDidLoad()
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testGivenExchangeViewModel_WhenViewDidLoad_ThenExchangeRateText_IsCorrectlyReturned() {
        let expectation = self.expectation(description: "Exchange Rate text returned")
        
        viewModel.exchangeRateText = { text in
            XCTAssertEqual(text, "")
            expectation.fulfill()
        }
        
        viewModel.viewDidLoad()
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testGivenExchangeViewModel_WhenViewDidLoad_ThenDestinationText_IsCorrectlyReturned() {
        let expectation = self.expectation(description: "Destination text returned")
        
        viewModel.destinationText = { text in
            XCTAssertEqual(text, self.translator.translate(key: "mobile/Exchange/destinationText"))
            expectation.fulfill()
        }
        
        viewModel.viewDidLoad()
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testGivenExchangeViewModel_WhenViewDidLoad_ThenDestinationAmountText_IsCorrectlyReturned() {
        let expectation = self.expectation(description: "Destination Amount text returned")
        
        viewModel.destinationAmountText = { text in
            XCTAssertEqual(text, "...")
            expectation.fulfill()
        }
        
        viewModel.viewDidLoad()
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testGivenExchangeViewModel_WhenViewDidLoad_ThenDestinationCurrencyNameText_IsCorrectlyReturned() {
        let expectation = self.expectation(description: "Destination Currency Name text returned")
        
        viewModel.destinationCurrencyNameText = { text in
            XCTAssertEqual(text, "Chainlink")
            expectation.fulfill()
        }
        
        viewModel.viewDidLoad()
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testGivenExchangeViewModel_WhenViewDidLoad_ThenDestinationCurrencySymbolText_IsCorrectlyReturned() {
        let expectation = self.expectation(description: "Destination Currency Symbol text returned")
        
        viewModel.destinationCurrencySymbolText = { text in
            XCTAssertEqual(text, "LINK")
            expectation.fulfill()
        }
        
        viewModel.viewDidLoad()
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testGivenExchangeViewModel_WhenViewDidLoad_ThenDestinationAddressText_IsCorrectlyReturned() {
        let expectation = self.expectation(description: "Destination Address text returned")
        
        viewModel.destinationAddressText = { text in
            XCTAssertEqual(text, self.translator.translate(key: "mobile/Exchange/destinationAddressText"))
            expectation.fulfill()
        }
        
        viewModel.viewDidLoad()
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testGivenExchangeViewModel_WhenViewDidLoad_ThenScanQRCodeImageText_IsCorrectlyReturned() {
        let expectation = self.expectation(description: "Scan QR Code Image text returned")
        
        viewModel.scanQRCodeImageText = { text in
            XCTAssertEqual(text, "qrcode.viewfinder")
            expectation.fulfill()
        }
        
        viewModel.viewDidLoad()
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testGivenExchangeViewModel_WhenViewDidLoad_ThenWarningImageText_IsCorrectlyReturned() {
        let expectation = self.expectation(description: "Warning Image text returned")
        
        viewModel.warningImageText = { text in
            XCTAssertEqual(text, "")
            expectation.fulfill()
        }
        
        viewModel.viewDidLoad()
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testGivenExchangeViewModel_WhenViewDidLoad_ThenWarningText_IsCorrectlyReturned() {
        let expectation = self.expectation(description: "Warning text returned")
        
        viewModel.warningText = { text in
            XCTAssertEqual(text, "")
            expectation.fulfill()
        }
        
        viewModel.viewDidLoad()
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testGivenExchangeViewModel_WhenViewDidLoad_ThenWarningAmountImageText_IsCorrectlyReturned() {
        let expectation = self.expectation(description: "Warning Amount text returned")
        
        viewModel.warningAmountText = { text in
            XCTAssertEqual(text, "")
            expectation.fulfill()
        }
        
        viewModel.viewDidLoad()
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testGivenExchangeViewModel_WhenViewDidLoad_ThenExchangeNowText_IsCorrectlyReturned() {
        let expectation = self.expectation(description: "Exchange Now text returned")
        
        viewModel.exchangeNowText = { text in
            XCTAssertEqual(text, self.translator.translate(key: "mobile/Exchange/exchangeNowText"))
            expectation.fulfill()
        }
        
        viewModel.viewDidLoad()
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testGivenExchangeViewModel_WhenViewDidLoad_ThenAlertState_IsCorrectlyReturned() {
        let expectation = self.expectation(description: "Alert State returned")
        
        viewModel.alertState = { text in
            XCTAssertEqual(text, true)
            expectation.fulfill()
        }
        
        viewModel.viewDidLoad()
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testGivenExchangeViewModel_WhenDidPressSwitch_ThenExchangeRateText_IsCorrectlyReturned() {
        let expectation = self.expectation(description: "Exchange Rate text returned")

        repository.priceResponse = mockPriceResponse

        var counter = 0
        viewModel.exchangeRateText = { text in
            if counter == 1 {
                XCTAssertEqual(text, "")
                expectation.fulfill()
            }
            counter += 1
        }

        viewModel.viewDidLoad()
        viewModel.didPressSwitch(originAmountText: "")
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testGivenExchangeViewModel_WhenDidPressWarningAmount_ThenOriginAmountText_IsCorrectlyReturned() {
        let expectation = self.expectation(description: "Origin Amount text returned")

        repository.priceResponse = mockPriceResponse

        var counter = 0
        viewModel.originAmountText = { text in
            if counter == 1 {
                XCTAssertEqual(text, "")
                expectation.fulfill()
            }
            counter += 1
        }

        viewModel.viewDidLoad()
        viewModel.didPressWarningAmount(warningAmountText: "", originAmount: "")
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testGivenExchangeViewModel_WhenGetRates_ThenExchangeRateText_IsCorrectlyReturned() {
        let expectation = self.expectation(description: "Exchange Rate Text returned")

        repository.priceResponse = mockPriceResponse

        var counter = 0
        viewModel.exchangeRateText = { text in
            if counter == 1 {
                XCTAssertEqual(text, "...")
                expectation.fulfill()
            }
            counter += 1
        }

        viewModel.viewDidLoad()
        viewModel.getRates(originAmountText: "1")
        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func testGivenExchangeViewModel_WhenDidPressElement_ThenActions_IsCorrectlyReturned() {
        let currency = Currency(name: "Ethereum",
                                symbol: "ETH",
                                active: "true",
                                image: "ETH",
                                id: "")
        let expectationDidSelectBoard = self.expectation(description: "Did Select Board  returned")
        let expectationDidSelectHowItWork = self.expectation(description: "Did Select How It Work returned")
        let expectationDidSelectOriginCurrency = self.expectation(description: "Did Select Origin Currency returned")
        let expectationDidSelectDestinationCurrency = self.expectation(description: "Did Select Destination Currency returned")
        let expectationDidDismissOriginCurrenciesList = self.expectation(description: "Did Select Dismiss Origin Currencies list returned")
//        let expectationDidDismissDestinationCurrenciesList = self.expectation(description: "Did Select Dismiss Destination Currencies list returned")
        let expectationDidSelectExchangeNow = self.expectation(description: "Did Select Exchange Now returned")
        repository.priceResponse = mockPriceResponse
        repository.addressResponse = mockAddressResponse
        let actions: ExchangeViewModel.Actions = .init(
            didPresentExchange: {
                
        },
            didSelectBoard: {
                expectationDidSelectBoard.fulfill()
        },
            didSelectHowItWork: {
                expectationDidSelectHowItWork.fulfill()
        },
            didSelectOriginCurrency: {
                expectationDidSelectOriginCurrency.fulfill()
        },
            didSelectDestinationCurrency: {
                expectationDidSelectDestinationCurrency.fulfill()
        },
            didDismissCurrenciesList: {
                expectationDidDismissOriginCurrenciesList.fulfill()
        },
            didSelectExchangeNow: { _ in
                expectationDidSelectExchangeNow.fulfill()
        },
            didPresentAlert: { _ in
            
        })

        viewModel = ExchangeViewModel(
            actions: actions,
            repository: self.repository,
            translator: self.translator
        )

        viewModel.viewDidLoad()
        viewModel.didPressBoard()
        viewModel.didPressHowItWork()
        viewModel.didPressOriginCurrency()
        viewModel.didPressDestinationCurrency()
        viewModel.updateOrigin(currency: currency, originAmountText: "1")
        viewModel.didPressExchangeNow(userID: "d",
                                      originAmountText: "1",
                                      refundAddressText: "f",
                                      destinationAmountText: "1.4",
                                      destinationAddressText: "0x89205A3A3b2A69De6Dbf7f01ED13B2108B2c43e7",
                                      exchangeRate: "1.2445")
        
    

        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
}

fileprivate final class MockExchangeRepository: ExchangeRepositoryType {
    
    var addressResponse: AddressResponse!
    var orderResponse: OrderResponse!
    var priceResponse: PriceResponse!
    
    func getAddressValidation(address: [String : String], callback: @escaping (AddressResponse) -> Void) {
        callback(addressResponse)
    }
    
    func postOrder(order: [String : String], callback: @escaping (OrderResponse) -> Void) {
        callback(orderResponse)
    }
    
    func getPrices(message: String, callback: @escaping (PriceResponse) -> Void) {
        callback(priceResponse)
    }
}
