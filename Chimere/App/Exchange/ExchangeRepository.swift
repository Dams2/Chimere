//
//  ExchangeRepository.swift
//  antex
//
//  Created by Damien Rojo on 16.04.20.
//  Copyright © 2020 Damien Rojo. All rights reserved.
//

import Foundation

protocol ExchangeRepositoryType: class {
    func getAddressValidation(address: [String: String], callback: @escaping (AddressResponse) -> Void)
    func postOrder(order: [String: String], callback: @escaping (OrderResponse) -> Void)
    func getPrices(message: String, callback: @escaping (PriceResponse) -> Void)
}

final class ExchangeRepository: ExchangeRepositoryType {
    
    let client: HTTPClient
    
    private let token = RequestCancellationToken()
    
    init(client: HTTPClient) {
        self.client = client
    }
    
    func getAddressValidation(address: [String: String], callback: @escaping (AddressResponse) -> Void) {
        let stringURL = "https://chimere.io/api/check/is-valid-address"
        guard let url = URL(string: stringURL) else { return }

        client.upload(type: AddressResponse.self,
                      requestType: .POST,
                      dictionary: address,
                      url: url,
                      cancelledBy: token) { (validation) in
                        callback(validation)
        }
    }
    
    func postOrder(order: [String: String] ,callback: @escaping (OrderResponse) -> Void) {
        let stringURL = "https://chimere.io/api/order/create-order"
        guard let url = URL(string: stringURL) else { return }

        client.upload(type: OrderResponse.self,
                      requestType: .POST,
                      dictionary: order,
                      url: url,
                      cancelledBy: token) { (deposit) in
                        callback(deposit)
        }
    }
    
    func getPrices(message: String, callback: @escaping (PriceResponse) -> Void) {
        let stringURL = "ws://chimere.io:8080/price"
        guard let url = URL(string: stringURL) else { return }
        
        client.websocketRequest(type: PriceResponse.self,
                                requestType: .GET,
                                url: url,
                                message: message,
                                cancelledBy: token) { (result) in
                                    callback(result)
        }
    }
}
