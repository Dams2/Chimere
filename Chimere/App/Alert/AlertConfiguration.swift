//
//  AlertConfiguration.swift
//  antex
//
//  Created by Damien Rojo on 15.04.20.
//  Copyright © 2020 Damien Rojo. All rights reserved.
//

import Foundation

struct AlertConfiguration: Equatable {
    let title: String
    let message: String
    let okMessage: String
    let cancelMessage: String?
}
