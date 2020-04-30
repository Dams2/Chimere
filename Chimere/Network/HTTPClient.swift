//
//  HTTPClient.swift
//  antex
//
//  Created by Damien Rojo on 14.04.20.
//  Copyright © 2020 Damien Rojo. All rights reserved.
//

import Foundation

enum RequestType: String {
    case GET = "GET"
    case POST = "POST"
}

final class HTTPClient {

    private let engine: HTTPEngine

    private let jsonDecoder: JSONDecoder

    init(engine: HTTPEngine) {
        self.engine = engine
        self.jsonDecoder = JSONDecoder()
    }

    func request<T>(type: T.Type,
                    requestType: RequestType,
                    url: URL,
                    cancelledBy token: RequestCancellationToken,
                    completion: @escaping (T) -> Void) where T: Codable {
        var request = URLRequest(url: url)
        request.httpMethod = requestType.rawValue

        engine.send(request: request, cancelledBy: token, callback: { data, _, _ in
            guard let data = data else { return }
            self.decodeJSON(type: T.self, data: data, completion: completion)
        })
    }

    func dataRequest(requestType: RequestType,
                     url: URL,
                     cancelledBy token: RequestCancellationToken,
                     completion: @escaping (Data) -> Void) {
        
        var request = URLRequest(url: url)
        request.httpMethod = requestType.rawValue
        
        engine.send(request: request, cancelledBy: token) { data, _, _ in
            guard let data = data else { return }
            completion(data)
        }
    }

    func upload<T>(type: T.Type,
                    requestType: RequestType,
                    array: [String: String],
                    url: URL,
                    cancelledBy token: RequestCancellationToken,
                    completion: @escaping (T) -> Void) where T: Codable {
        var request = URLRequest(url: url)
        request.httpMethod = requestType.rawValue
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: array, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
        }

        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        engine.send(request: request, cancelledBy: token, callback: { data, _, _ in
            guard let data = data else { return }

            self.decodeJSON(type: T.self, data: data, completion: completion)
        })
    }
    
    func websocketRequest<T>(type: T.Type,
                             requestType: RequestType,
                             url: URL,
                             cancelledBy token: RequestCancellationToken,
                             completion: @escaping (T) -> Void) where T: Codable{
        var request = URLRequest(url: url)
        request.httpMethod = requestType.rawValue
        
        engine.sendWebsocket(request: request, cancelledBy: token, callback: { data, _, _ in
            guard let data = data else { return }
            self.decodeJSON(type: T.self, data: data, completion: completion)
        })
    }

    private func decodeJSON<T>(type: T.Type, data: Data, completion: @escaping (T) -> Void) where T: Codable {
        guard let decodedData = try? jsonDecoder.decode(type.self, from: data) else {
            print("Decoder was unable to decode: \(type.self)")
            return
        }
        completion(decodedData)
    }
}
