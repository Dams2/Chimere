//
//  UserOrdersResponse.swift
//  Chimere
//
//  Created by Damien Rojo on 30.04.20.
//  Copyright © 2020 Damien Rojo. All rights reserved.
//

import Foundation

struct UserOrdersResponse: Codable {
    let orders: [Order]
}
