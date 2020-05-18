//
//  Translator.swift
//  Chimere
//
//  Created by Damien Rojo on 11.05.20.
//  Copyright © 2020 Damien Rojo. All rights reserved.
//

import Foundation

final class Translator {

    private(set) var locale: String

    init(with locale: String) {
        self.locale = locale
    }

    func translate(key: String) -> String {
        return getString(for: key)
    }

    private func getString(for key: String) -> String {
        return NSLocalizedString(key, comment: "")

    }
}
