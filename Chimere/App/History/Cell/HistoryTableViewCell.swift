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
            statusView.layer.borderWidth = 1
            statusView.layer.borderColor = #colorLiteral(red: 0.9490196078, green: 0.862745098, blue: 0.6078431373, alpha: 1)
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
        
        let translator = Translator(with: "")

        guard userOrders.state["Failed"] == false else {
            self.statusLabel.text = translator.translate(key: "mobile/History/failed")
            self.statusLabel.textColor = #colorLiteral(red: 0.9490196078, green: 0.1137254902, blue: 0.1137254902, alpha: 1)
            return
        }

        if userOrders.state["Loaded"] == false && userOrders.state["Exchanging"] == false && userOrders.state["Completed"] == false {
            self.statusLabel.text = translator.translate(key: "mobile/History/notPaid")
            self.statusLabel.textColor = #colorLiteral(red: 0.9490196078, green: 0.862745098, blue: 0.6078431373, alpha: 1)
        } else {
            self.statusLabel.text = translator.translate(key: "mobile/History/paid")
            self.statusLabel.textColor = #colorLiteral(red: 0.3529411765, green: 0.4509803922, blue: 0.007843137255, alpha: 1)
        }
        
        if userOrders.state["Exchanging"] == true {
            self.statusLabel.text = "Exchanging"
            self.statusLabel.textColor = #colorLiteral(red: 0.3529411765, green: 0.4509803922, blue: 0.007843137255, alpha: 1)
        }
        
        if userOrders.state["Exchanged"] == true {
            self.statusLabel.text = "Exchanged"
            self.statusLabel.textColor = #colorLiteral(red: 0.3529411765, green: 0.4509803922, blue: 0.007843137255, alpha: 1)
        }
        
        if userOrders.state["Sending"] == true {
            self.statusLabel.text = "Sending"
            self.statusLabel.textColor = #colorLiteral(red: 0.3529411765, green: 0.4509803922, blue: 0.007843137255, alpha: 1)
        }
        
        if userOrders.state["Completed"] == true {
            self.statusLabel.text = translator.translate(key: "mobile/History/completed")
            self.statusLabel.textColor = #colorLiteral(red: 0.3529411765, green: 0.4509803922, blue: 0.007843137255, alpha: 1)
        }
        
        guard userOrders.state["Expired"] == false else {
            self.statusLabel.text = translator.translate(key: "mobile/History/expired")
            self.statusLabel.textColor = #colorLiteral(red: 0.9490196078, green: 0.1137254902, blue: 0.1137254902, alpha: 1)
            return
        }
    }
}
