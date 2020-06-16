//
//  CurrenciesListViewModel.swift
//  Chimere
//
//  Created by Damien Rojo on 22.04.20.
//  Copyright © 2020 Damien Rojo. All rights reserved.
//

import Foundation

final class CurrenciesListViewModel {
    
    // MARK: - Private Properties
    
    private let delegate: CurrenciesListViewControllerDelegate?
    
    private let repository: CurrenciesListRepository
    
    init(delegate: CurrenciesListViewControllerDelegate?, repository: CurrenciesListRepository) {
        self.delegate = delegate
        self.repository = repository
    }
    
    // MARK: - Outputs
    
    var items: (([Currency]) -> Void)?
    
    private var currencyItems: [CurrencyItem] = [] {
        didSet {
            let items = currencyItems.map { Currency(currencyItem:  $0) }
            self.items?(items)
        }
    }
    
    enum CurrencyItem {
        case active(response: Asset)
    }
    // MARK: - Inputs
    
    func viewDidLoad() {
        repository.getCurrencies { (currenciesResponse) in
            DispatchQueue.main.async {
                currenciesResponse.asset.lazy.forEach { self.currencyItems.append(.active(response: $0)) }
            }
        }
    }
    
    
    func didSelectItem(at index: Int) {
        guard index < currencyItems.count else { return }
        let item = currencyItems[index]
        let currency = Currency(currencyItem: item)
        delegate?.didSelect(currency)
    }

    func temp() {
        let arr = ["be", "ba" , "bi", "r" ,"a"]
        let sortedArr = arr.sorted { $0 < $1 }

        let arraay = [Currency(name: "a", symbol: "A", price: "12", active: "wtf", image: "wtf"), Currency(name: "a", symbol: "A", price: "12", active: "wtf", image: "wtf"), Currency(name: "a", symbol: "A", price: "12", active: "wtf", image: "wtf"), Currency(name: "a", symbol: "A", price: "12", active: "wtf", image: "wtf"), Currency(name: "a", symbol: "A", price: "12", active: "wtf", image: "wtf")]

        var dict: [String: Currency] = [:]
        arraay.forEach {
            dict[$0.symbol] = $0
        }

        let itaaa = dict.values
        let letters = dict.keys
    }
}

extension Currency {
    init(currencyItem: CurrenciesListViewModel.CurrencyItem) {
        switch currencyItem {
        case .active(response: let response):
            self = Currency(response: response)
        }
    }
}
