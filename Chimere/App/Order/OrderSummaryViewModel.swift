//
//  OrderSummaryViewModel.swift
//  Chimere
//
//  Created by Damien Rojo on 23.04.20.
//  Copyright © 2020 Damien Rojo. All rights reserved.
//

import Foundation

final class OrderSummaryViewModel {
    
    private let delegate: OrderSummaryViewControllerDelegate?
    
    private let repository: ExchangeRepositoryType

    init(delegate: OrderSummaryViewControllerDelegate?, repository: ExchangeRepositoryType) {
        self.delegate = delegate
        self.repository = repository
    }
    
    // MARK: - Outputs
    
    
    
    // MARK: - Inputs
    
    func viewDidLoad() {
        let orderItems: [String: Any] = ["deposit_amount": "120", "deposit_ticker": "ETH", "refund_address": "0xa2fec727757e47c64942e23949da839e6da948ac", "destination_amount": "34", "destination_ticker": "BTC", "destination_address": "18cBEMRxXHqzWWCxZNtU91F5sbUNKhL5PX"]
               
        repository.postOrder(order: orderItems) { (depositResponse) in
           
        }

    }
    
    func didPressConfirm(deposit: Deposit) {
        delegate?.didSelectConfirm(deposit: deposit)
    }
}
