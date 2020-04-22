//
//  ImageRepository.swift
//  antex
//
//  Created by Damien Rojo on 17.04.20.
//  Copyright © 2020 Damien Rojo. All rights reserved.
//

import UIKit

final class ImageRepository {
    
    // MARK: - Properties

    static let shared = ImageRepository(client: HTTPClient(engine: HTTPEngine()))

    private let client: HTTPClient
    
    let token = RequestCancellationToken()

    init(client: HTTPClient) {
        self.client = client
    }

    // MARK: - ImageRepositoryType
    
    func getImage(for url: URL, callback: @escaping (Data?) -> Void) {
        client.dataRequest(requestType: .GET, url: url, cancelledBy: token) { (data) in
            print(data)
            callback(data)
        }
    }
}
