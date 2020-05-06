//
//  HTTPEngine.swift
//  antex
//
//  Created by Damien Rojo on 14.04.20.
//  Copyright © 2020 Damien Rojo. All rights reserved.
//

import Foundation

typealias HTTPCompletionHander = (Data?, HTTPURLResponse?, Error?) -> Void

enum URLSessionEngineError: Error {
    case invalideURLResponseType
}

final class HTTPEngine {

    private let session: URLSession

    init(configuration: URLSessionConfiguration = .default) {
        self.session = URLSession(configuration: configuration)
    }
    
    func send(request: URLRequest,
              cancelledBy token: RequestCancellationToken,
              callback: @escaping HTTPCompletionHander) {
        
        let task = session.dataTask(with: request) { (data, urlResponse, _) in
            if urlResponse != nil, let httpUrlResponse = urlResponse as? HTTPURLResponse {
                callback(data, httpUrlResponse, nil)
            } else {
                callback(data, nil, URLSessionEngineError.invalideURLResponseType)
            }
        }
        
        task.resume()
        token.willDealocate = {
            task.cancel()
        }
    }
    
    func sendWebsocket(request: URLRequest,
                       cancelledBy token: RequestCancellationToken,
                       callback: @escaping HTTPCompletionHander) {

        let task = session.webSocketTask(with: request)

        let message = URLSessionWebSocketTask.Message.string("Envoi les prix cornio")

        task.send(message) { (error) in
            if let error = error {
                print("WebSocket sending error: \(error) !!!")
            }
        }
        
        task.receive { (result) in
            switch result {
            case .failure(_):
                print("Failed to receive message !!!")
            case .success(let message):
                switch message {
                case .string(let text):
                    let data = Data(text.utf8)
                    callback(data, nil, nil)
                case .data(let data):
                    print(data)
                @unknown default:
                    print("Fatal ERROR !!!")
                }
            }
        }
        
        task.resume()
        token.willDealocate = {
            task.cancel()
        }
    }

    deinit {
        session.invalidateAndCancel()
    }
}
