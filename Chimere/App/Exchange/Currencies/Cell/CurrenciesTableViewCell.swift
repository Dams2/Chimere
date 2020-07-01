//
//  CurrenciesTableViewCell.swift
//  antex
//
//  Created by Damien Rojo on 16.04.20.
//  Copyright © 2020 Damien Rojo. All rights reserved.
//

import UIKit

final class CurrenciesTableViewCell: UITableViewCell {
    
    // MARK: - Private Properties
    
    private var client: HTTPClient!
    
    // MARK: - Outlets
    
    @IBOutlet weak private var currencyImageView: UIImageView!
    
    @IBOutlet weak private var currencyNameLabel: UILabel!
    
    @IBOutlet weak private var currencySymbolLabel: UILabel!
    
    var active = ""
    
    // MARK: - Action
    
    func configure(with currency: Currency) {
        active = currency.active
        
        if active == "false" {
            self.isUserInteractionEnabled = false
            let isDisable = "Disable"
            self.currencySymbolLabel.text = "(\(isDisable))"
        }
        currencyImageView.image = UIImage(named: currency.symbol)
        
        currencyNameLabel.text = currency.name
        if active == "true" {
            self.isUserInteractionEnabled = true
            currencySymbolLabel.text = currency.symbol
        }
    }
}
