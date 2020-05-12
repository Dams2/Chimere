//
//  Translator.swift
//  Chimere
//
//  Created by Damien Rojo on 11.05.20.
//  Copyright © 2020 Damien Rojo. All rights reserved.
//

import Foundation

final class Translator {

    let locale: String

    private var bundle: Bundle? = nil

    init(with locale: String) {
        self.locale = locale
        createCustomBundleIfNeeded(for: locale)
        loadLocalizedFile(for: locale)
    }

    private func createCustomBundleIfNeeded(for locale: String ) {
        
    }
    
    private func loadLocalizedFile(for locale: String) {
        
    }

    func translate(key: String) -> String {
        return getString(for: key)
    }

    private func getString(for key: String) -> String {
        if bundle == nil {
            bundle = Bundle(path: bundlePath(for: locale))
        }

        assert(bundle != nil, "Custom bundle can't be nil")
//        return bundle?.localizedString(forKey: key,
//                                       value: nil,
//                                       table: nil) ?? ""
        return strings[key] ?? ""
    }

    let bundleFileName = "localized-string.bundle"
    private func bundlePath(for locale: String) -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory,
                                                        .userDomainMask,
                                                        true)
        let documentDirectory = paths.first ?? ""
        return "\(documentDirectory)/\(bundleFileName)/\(locale).lproj"
    }
}

private let strings = [
    "mobile.marketplace/orderpipe/alert-title-not-set.text": "Alerte!",
    "key2": "Value"
]
