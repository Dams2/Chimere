//
//  AddressResponse.swift
//  antex
//
//  Created by Damien Rojo on 16.04.20.
//  Copyright © 2020 Damien Rojo. All rights reserved.
//

import Foundation

// MARK: - AddressResponse
struct AddressResponse: Codable {
    let isvalid: Bool?
    let error: String?
}
