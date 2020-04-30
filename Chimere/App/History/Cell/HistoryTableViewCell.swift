//
//  HistoryTableViewCell.swift
//  Chimere
//
//  Created by Damien Rojo on 23.04.20.
//  Copyright © 2020 Damien Rojo. All rights reserved.
//

import UIKit

final class HistoryTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var statusView: UIView! {
        didSet {
            statusView.layer.cornerRadius = 10
        }
    }

    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var depositCurrencyImageView: UIImageView!
    
    @IBOutlet weak var depositAmountLabel: UILabel!
    
    @IBOutlet weak var depositCurrencySymbolLabel: UILabel!
    
    @IBOutlet weak var toImageView: UIImageView!
    
    @IBOutlet weak var destinationCurrencyImageView: UIImageView!
    
    @IBOutlet weak var destinationAmountLabel: UILabel!
    
    @IBOutlet weak var destinationCurrencySymbolLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    // MARK: - Actions
    
    override var frame: CGRect {
        get {
            return super.frame
        }
        set (newFrame) {
            var frame =  newFrame
            frame.origin.y += 4
            frame.size.height -= 2 * 5
            super.frame = frame
        }
      }

    func configure(with deposit: UserOrders) {
        depositAmountLabel.text = "\(deposit.depositAmount)"
        depositCurrencySymbolLabel.text = deposit.depositSymbol
        destinationAmountLabel.text = "\(deposit.destinationAmount)"
        destinationCurrencySymbolLabel.text = deposit.destinationSymbol
        dateLabel.text = deposit.createdDate
    }
}
