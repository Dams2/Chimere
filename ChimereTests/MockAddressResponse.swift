//
//  MockAddressResponse.swift
//  ChimereTests
//
//  Created by Damien Rojo on 07.10.20.
//  Copyright © 2020 Damien Rojo. All rights reserved.
//

import Foundation
@testable import Chimere

private let addressResponseJSONData = """
{
   "valid":true
}
""".data(using: .utf8)!

let mockAddressResponse = try! JSONDecoder().decode(AddressResponse.self, from: addressResponseJSONData)
