//
//  HistoryViewModel.swift
//  Chimere
//
//  Created by Damien Rojo on 21.04.20.
//  Copyright © 2020 Damien Rojo. All rights reserved.
//

import Foundation

final class HistoryViewModel {
    
    let repository: HistoryRepositoryType
    
    init(repository: HistoryRepositoryType) {
        self.repository = repository
    }
    
    // MARK: - Outputs
    
    var items: (([Orders]) -> Void)?
    
    private var historyItems: [HistoryItems] = [] {
        didSet {
            let items = historyItems.map { Orders(historyItems:  $0) }
            self.items?(items)
        }
    }
    
    enum HistoryItems {
        case order(response: OrderResponse)
    }
    
    // MARK: - Inputs
    
    func viewDidLoad(userID: String) {
        repository.findOrders(order: ["owner": userID]) { (depositResponse) in
            DispatchQueue.main.async {
                 self.historyItems.append(.order(response: depositResponse))
            }
        }
    }
}

extension Orders {
    init(historyItems: HistoryViewModel.HistoryItems) {
        switch historyItems {
        case .order(response: let response):
            self = Orders(response: response)
        }
    }
}
