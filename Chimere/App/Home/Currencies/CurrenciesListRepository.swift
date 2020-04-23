//
//  CurrenciesListRepository.swift
//  Chimere
//
//  Created by Damien Rojo on 22.04.20.
//  Copyright © 2020 Damien Rojo. All rights reserved.
//

import Foundation

protocol CurrenciesListRepositoryType: class {
    func getCurrencies(callback: @escaping (CurrenciesResponse) -> Void)
}

final class CurrenciesListRepository: CurrenciesListRepositoryType {

    let client: HTTPClient

    private let token = RequestCancellationToken()

    init(client: HTTPClient) {
        self.client = client
    }
    
    func getCurrencies(callback: @escaping (CurrenciesResponse) -> Void) {
        let stringURL = "https://361d6e5c.ngrok.io/api/asset/retrieve-all-active-asset"
        guard let url = URL(string: stringURL) else { return }
        client.request(type: CurrenciesResponse.self,
                       requestType: .GET,
                       url: url,
                       cancelledBy: token,
                       completion: { currenciesResponse in
                        callback(currenciesResponse)
        })
    }
}
