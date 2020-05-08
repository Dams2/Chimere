//
//  HistoryViewModel.swift
//  Chimere
//
//  Created by Damien Rojo on 21.04.20.
//  Copyright © 2020 Damien Rojo. All rights reserved.
//

import Foundation

final class HistoryViewModel {
    
    // MARK: - Private Properties
    
    private let delegate: HistoryViewControllerDelegate?
    
    private let repository: HistoryRepositoryType
    
    init(delegate: HistoryViewControllerDelegate?, repository: HistoryRepositoryType) {
        self.delegate = delegate
        self.repository = repository
    }

    // MARK: - Outputs
    
    var emptyOrderText: ((String) -> Void)?
    var exchangeNowText: ((String) -> Void)?
    
    var loadingState: ((State) -> Void)?
    
    enum State {
        case isTrue
        case isFalse
        case isEmpty
    }
    
    var items: (([UserOrders]) -> Void)?
    
    private var historyItem: [HistoryItems] = [] {
        didSet {
            let items = historyItem.map { UserOrders(historyItem:  $0) }
            self.items?(items)
            print(items)
        }
    }
    
    enum HistoryItems {
        case order(response: Order)
    }
    
    // MARK: - Inputs
    
    func viewDidLoad(userID: String) {
        findOrder(userID: userID)
    }
    
    func didSelectItem(at index: Int) {
        guard index < historyItem.count else { return }
        let item = historyItem[index]
        let order = UserOrders(historyItem: item)
        delegate?.didSelect(order)
    }
    
    func findOrder(userID: String) {
        loadingState?(.isTrue)
        repository.findOrders(order: ["owner": userID]) { (orderResponse) in
            DispatchQueue.main.async {
                self.loadingState?(.isFalse)
                orderResponse.orders.forEach { self.historyItem.append(.order(response: $0)) }
                guard !self.historyItem.isEmpty else {
                    self.loadingState?(.isEmpty)
                    self.emptyOrderText?("You have no order")
                    self.exchangeNowText?("Exchange now")
                    return
                }
            }
        }
    }
    
    func didPressExchangeNow() {
        delegate?.didShowExchange()
    }
}

extension UserOrders {
    init(historyItem: HistoryViewModel.HistoryItems) {
        switch historyItem {
        case .order(response: let response):
            self = UserOrders(response: response)
        }
    }
}
