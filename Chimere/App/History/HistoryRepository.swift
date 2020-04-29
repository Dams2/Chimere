//
//  HistoryRepository.swift
//  Chimere
//
//  Created by Damien Rojo on 29.04.20.
//  Copyright © 2020 Damien Rojo. All rights reserved.
//

import Foundation

protocol HistoryRepositoryType: class {
    func findOrders(order: [String: String] ,callback: @escaping (OrderResponse) -> Void)
}
//find-orders
final class HistoryRepository: HistoryRepositoryType {
    
    let client: HTTPClient
    
    private let token = RequestCancellationToken()
    
    init(client: HTTPClient) {
        self.client = client
    }
    
    func findOrders(order: [String: String] ,callback: @escaping (OrderResponse) -> Void) {
        let stringURL = "https://08865228.ngrok.io/api/order/find-orders"
        guard let url = URL(string: stringURL) else { return }

        client.upload(type: OrderResponse.self,
                      requestType: .POST,
                      array: order,
                      url: url,
                      cancelledBy: token) { (deposit) in
                        callback(deposit)
        }
    }
}
