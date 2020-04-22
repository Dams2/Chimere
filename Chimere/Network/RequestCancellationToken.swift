//
//  RequestCancellationToken.swift
//  antex
//
//  Created by Damien Rojo on 14.04.20.
//  Copyright © 2020 Damien Rojo. All rights reserved.
//

import Foundation

final class RequestCancellationToken {
    
    init() {}
    
    deinit {
        willDealocate?()
    }
    
    var willDealocate: (() -> Void)?
}
