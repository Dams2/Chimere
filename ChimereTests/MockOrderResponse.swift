//
//  MockOrderResponse.swift
//  ChimereTests
//
//  Created by Damien Rojo on 07.10.20.
//  Copyright © 2020 Damien Rojo. All rights reserved.
//

import Foundation
@testable import Chimere

private let orderResponseJSONData = """
{
   "order":{
      "state":{
         "loaded":false,
         "exchanging":false,
         "exchanged":false,
         "sending":false,
         "completed":false,
         "expired":false,
         "failed":false
      },
      "_id":"5f7da95ac5acef1a7971acd4",
      "owner":"A10FEB42-43BD-4C6B-A77D-A91755F72158",
      "deposit_amount":1,
      "deposit_ticker":"ETH",
      "deposit_address":"0x8983081cf9839884Dc58810333612BD93fb0e354",
      "destination_ticker":"LINK",
      "destination_address":"0x89205A3A3b2A69De6Dbf7f01ED13B2108B2c43e7",
      "destination_amount":39.0993766785,
      "refund_address":"refundAddressText",
      "created_date":"2020-10-07T11:41:14.752Z"
   }
}
""".data(using: .utf8)!

let mockOrderResponse = try! JSONDecoder().decode(OrderResponse.self, from: orderResponseJSONData)
