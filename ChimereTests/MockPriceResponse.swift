//
//  MockPriceResponse.swift
//  ChimereTests
//
//  Created by Damien Rojo on 30.09.20.
//  Copyright © 2020 Damien Rojo. All rights reserved.
//

import Foundation
@testable import Chimere

private let priceResponseJSONData = """
{
   "askPrice":{
      "ticker":"String",
      "exchange":"String",
      "best_ask":"String"
   },
   "bidPrice":{
      "ticker":"String",
      "exchange":"String",
      "best_bid":"String"
   },
   "askMin":"String",
   "askMax":"String"
}
""".data(using: .utf8)!

let mockPriceResponse = try! JSONDecoder().decode(PriceResponse.self, from: priceResponseJSONData)
