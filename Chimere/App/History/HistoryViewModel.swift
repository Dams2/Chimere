//
//  HistoryViewModel.swift
//  Chimere
//
//  Created by Damien Rojo on 21.04.20.
//  Copyright © 2020 Damien Rojo. All rights reserved.
//

import Foundation

final class HistoryViewModel {
    
    let delegate: HistoryViewControllerDelegate?
    
    let repository: HistoryRepositoryType
    
    init(delegate: HistoryViewControllerDelegate?, repository: HistoryRepositoryType) {
        self.delegate = delegate
        self.repository = repository
    }
    
    // MARK: - Outputs
    
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
        repository.findOrders(order: ["owner": userID]) { (orderResponse) in
            DispatchQueue.main.async {
                orderResponse.orders.forEach { self.historyItem.append(.order(response: $0)) }
            }
        }
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
