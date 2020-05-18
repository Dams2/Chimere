//
//  HistoryTableViewCell.swift
//  Chimere
//
//  Created by Damien Rojo on 23.04.20.
//  Copyright © 2020 Damien Rojo. All rights reserved.
//

import UIKit

final class HistoryTableViewCell: UITableViewCell {
    
    // MARK: - Private Properties
    
    private let helper = Helper()

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

    func configure(with userOrders: UserOrders) {
        depositCurrencyImageView.image = UIImage(named: userOrders.originSymbol)
        depositAmountLabel.text = "\(userOrders.originAmount)"
        depositCurrencySymbolLabel.text = userOrders.originSymbol
        toImageView.image = UIImage(systemName: "chevron.down")
        destinationCurrencyImageView.image = UIImage(named: userOrders.destinationSymbol)
        destinationAmountLabel.text = "\(userOrders.destinationAmount)"
        destinationCurrencySymbolLabel.text = userOrders.destinationSymbol
        dateLabel.text = userOrders.createdDate
        
        guard userOrders.state["Failed"] == false else {
            self.statusLabel.text = "Failed"
            self.statusLabel.textColor = #colorLiteral(red: 1, green: 0, blue: 0.1764705882, alpha: 1)
            return
        }
        
        guard userOrders.state["Failed"] == false else {
            self.statusLabel.text = "Failed"
            self.statusLabel.textColor = #colorLiteral(red: 1, green: 0, blue: 0.1764705882, alpha: 1)
            return
        }
        
        if userOrders.state["Loaded"] == false && userOrders.state["Exchanging"] == false && userOrders.state["Completed"] == false {
            self.statusLabel.text = "Not paid"
            self.statusLabel.textColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        } else {
            self.statusLabel.text = "Paid"
            self.statusLabel.textColor = #colorLiteral(red: 0.380194066, green: 0.8453993896, blue: 0.1441816635, alpha: 1)
            if userOrders.state["Completed"] == true {
                self.statusLabel.text = "Completed"
                self.statusLabel.textColor = #colorLiteral(red: 0.380194066, green: 0.8453993896, blue: 0.1441816635, alpha: 1)
            }
        }
        
        if userOrders.state["Completed"] == true {
            self.statusLabel.text = "Completed"
            self.statusLabel.textColor = #colorLiteral(red: 0.380194066, green: 0.8453993896, blue: 0.1441816635, alpha: 1)
        }
        
        guard userOrders.state["Expired"] == false else {
            self.statusLabel.text = "Expired"
            self.statusLabel.textColor = #colorLiteral(red: 1, green: 0, blue: 0.1770516336, alpha: 1)
            return
        }
    }
}
