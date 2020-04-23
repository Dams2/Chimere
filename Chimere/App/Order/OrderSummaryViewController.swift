//
//  OrderSummaryViewController.swift
//  Chimere
//
//  Created by Damien Rojo on 23.04.20.
//  Copyright © 2020 Damien Rojo. All rights reserved.
//

import UIKit

final class OrderSummaryViewController: UIViewController {
    
    // MARK: - Private Properties
    
    var viewModel: OrderSummaryViewModel!
        
    // MARK: - Outlets
    
    @IBOutlet weak private var orderLabel: UILabel!
    
    @IBOutlet weak private var originLabel: UILabel!
    
    @IBOutlet weak private var originAmountLabel: UILabel!
    
    @IBOutlet weak private var destinationLabel: UILabel!
    
    @IBOutlet weak private var destinationAmountLabel: UILabel!
    
    @IBOutlet weak private var destinationAddressLabel: UILabel!
    
    @IBOutlet weak private var destinationAddressTextField: UITextView!
    
    
    @IBOutlet weak private var infoView: UIView!  {
        didSet {
            infoView.layer.borderWidth = 1
            infoView.layer.borderColor = #colorLiteral(red: 0.9294117647, green: 0.9490196078, blue: 0.968627451, alpha: 1)
            infoView.layer.cornerRadius = 0
       }
    }
    
    @IBOutlet weak private var exchangeRatesLabel: UILabel!
    
    @IBOutlet weak private var exchangeRatesAmountLabel: UILabel!
    
    @IBOutlet weak private var totalFeeLabel: UILabel!
    
    @IBOutlet weak private var totalFeeAmountLabel: UILabel!
    
    @IBOutlet weak private var networkFee: UILabel!
    
    @IBOutlet weak private var networkFeeAmount: UILabel!
    
    @IBOutlet weak private var arrivalTimeLabel: UILabel!
    
    @IBOutlet weak private var estimatedTimeArrivalLabel: UILabel!
    
    
    @IBOutlet weak private var confirmButton: UIButton!  {
       didSet {
           confirmButton.layer.cornerRadius = 10
       }
    }

    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.tintColor = #colorLiteral(red: 1, green: 0.4872516394, blue: 0.8796543479, alpha: 1)
    }
    
    // MARK: - Helpers
    
    
    
    // MARK: - Actions
    
    @IBAction private func didPressConfirmButton(_ sender: UIButton) {
        let deposit = Deposit(id: "", depositAmount: "", depositSymbol: "", depositAddress: "", destinationAmount: "", destinationSymbol: "", destinationAddress: "", createdDate: "")
        viewModel.didPressConfirm(deposit: deposit)
    }
}
