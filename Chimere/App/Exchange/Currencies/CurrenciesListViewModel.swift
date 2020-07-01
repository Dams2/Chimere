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

    var searchBarPlaceholderText: ((String) -> Void)?

    var items: (([Currency]) -> Void)?

    private var currencyItems: [CurrencyItem] = [] {
        didSet {
            let items = currencyItems.map { Currency(currencyItem:  $0) }
            self.items?(items)
        }
    }

    private var filteredItems: [CurrencyItem] = [] {
        didSet {
            let items = filteredItems.map { Currency(currencyItem:  $0) }
            self.items?(items)
        }
    }

    enum CurrencyItem {
        case active(response: Asset)
    }

    // MARK: - Inputs

    func viewDidLoad() {
        searchBarPlaceholderText?("Try 'Bitcoin' or 'BTC'")
        repository.getCurrencies { (currenciesResponse) in
            DispatchQueue.main.async {
                currenciesResponse.asset.lazy.forEach { self.currencyItems.append(.active(response: $0)) }
            }
        }
    }

    func didSelectItem(at index: Int) {
        guard currencyItems.indices.contains(index) else { return }
        let item = currencyItems[index]
        let currency = Currency(currencyItem: item)
        delegate?.didSelect(currency)
    }

    func didSearchCurrency(with name: String) {
        let unfilteredItems = self.currencyItems
        if name == "" {
            self.currencyItems = unfilteredItems
            return
        }
        
        self.filteredItems = currencyItems.filter {
            switch $0 {
            case .active(response: let asset):
                return asset.currency.lowercased().contains(name.lowercased()) || asset.ticker.lowercased().contains(name.lowercased())
            }
        }
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
