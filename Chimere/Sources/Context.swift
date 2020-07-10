//
//  Context.swift
//  antex
//
//  Created by Damien Rojo on 14.04.20.
//  Copyright © 2020 Damien Rojo. All rights reserved.
//

import Foundation

final class Context {

    // MARK: - Properties

    public let client: HTTPClient
    public let translator: Translator

    // MARK: - Init

    init() {
        let engine = HTTPEngine(configuration: .default)
        client = HTTPClient(engine: engine)
        translator = Translator(with: Locale.current.languageCode ?? "en")
    }
}
