//
//  ExchangeRepository.swift
//  antex
//
//  Created by Damien Rojo on 16.04.20.
//  Copyright © 2020 Damien Rojo. All rights reserved.
//

import Foundation

protocol ExchangeRepositoryType: class {
    func getAddressValidation(for address: String, symbol: String, callback: @escaping (Bool) -> Void)
    func postOrder(order: [String: String], callback: @escaping (OrderResponse) -> Void)
    func getPrices(callback: @escaping (PriceResponse) -> Void)
}

final class ExchangeRepository: ExchangeRepositoryType {
    
    let client: HTTPClient
    
    private let token = RequestCancellationToken()
    
    init(client: HTTPClient) {
        self.client = client
    }
    
    func getAddressValidation(for address: String, symbol: String, callback: @escaping (Bool) -> Void) {
        
        let stringURL = "https://shapeshift.io/validateAddress/\(address)/\(symbol)"
        guard let url = URL(string: stringURL) else { return }
        client.request(type: AddressResponse.self,
                       requestType: .GET,
                       url: url,
                       cancelledBy: token,
                       completion: { addressResponse in
                        guard let isValid = addressResponse.isvalid else { return }
                        callback(isValid)
        })
    }
    
    func postOrder(order: [String: String] ,callback: @escaping (OrderResponse) -> Void) {
        let stringURL = "https://e6186bfb.ngrok.io/api/order/create-order"
        guard let url = URL(string: stringURL) else { return }

        client.upload(type: OrderResponse.self,
                      requestType: .POST,
                      array: order,
                      url: url,
                      cancelledBy: token) { (deposit) in
                        callback(deposit)
        }
    }
    
    func getPrices(callback: @escaping (PriceResponse) -> Void) {
        let stringURL = "https://109bcb96.ngrok.io/price"
        guard let url = URL(string: stringURL) else { return }
        
        client.websocketRequest(type: PriceResponse.self,
                                requestType: .GET,
                                url: url,
                                cancelledBy: token) { (result) in
                                    callback(result)
        }
    }
}
