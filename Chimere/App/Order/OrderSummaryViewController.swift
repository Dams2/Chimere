//
//  OrderSummaryViewController.swift
//  Chimere
//
//  Created by Damien Rojo on 23.04.20.
//  Copyright © 2020 Damien Rojo. All rights reserved.
//

import UIKit

final class OrderSummaryViewController: UIViewController {
    
    // MARK: - Properties
    
    var viewModel: OrderSummaryViewModel!
        
    // MARK: - Outlets
    
    @IBOutlet weak private var orderLabel: UILabel!
    
    @IBOutlet weak private var originLabel: UILabel!
    
    @IBOutlet weak private var originAmountLabel: UILabel!
    
    @IBOutlet weak private var destinationLabel: UILabel!
    
    @IBOutlet weak private var destinationAmountLabel: UILabel!
    
    @IBOutlet weak private var destinationAddressLabel: UILabel!
    
    @IBOutlet weak private var destinationTokenAddressTextField: UITextView!
    
    
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
    
    @IBOutlet weak private var networkFeeLabel: UILabel!
    
    @IBOutlet weak private var networkFeeAmountLabel: UILabel!
    
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
        
        bind(to: viewModel)
        viewModel.viewDidLoad()
    }
    
    // MARK: - Helpers
    
    func bind(to viewModel: OrderSummaryViewModel) {
        viewModel.orderText = { [weak self] text in
            DispatchQueue.main.async {
                self?.orderLabel.text = text
            }
        }
        
        viewModel.originText = { [weak self] text in
            DispatchQueue.main.async {
                self?.originLabel.text = text
            }
        }
        
        viewModel.originAmountText = { [weak self] text in
            DispatchQueue.main.async {
                self?.originAmountLabel.text = text
            }
        }
        
        viewModel.destinationText = { [weak self] text in
            DispatchQueue.main.async {
                self?.destinationLabel.text = text
            }
        }
        
        viewModel.destinationAmountText = { [weak self] text in
            DispatchQueue.main.async {
                self?.destinationAmountLabel.text = text
            }
        }
        
        viewModel.destinationAddressText = { [weak self] text in
            DispatchQueue.main.async {
                self?.destinationAddressLabel.text = text
            }
        }
        
        viewModel.destinationTokenAddressText = { [weak self] text in
            DispatchQueue.main.async {
                self?.destinationTokenAddressTextField.text = text
            }
        }
        
        viewModel.exchangeRateText = { [weak self] text in
            DispatchQueue.main.async {
                self?.exchangeRatesLabel.text = text
            }
        }
        
        viewModel.exchangeRatesAmountText = { [weak self] text in
            DispatchQueue.main.async {
                self?.exchangeRatesAmountLabel.text = text
            }
        }
        
        viewModel.totalFeeText = { [weak self] text in
            DispatchQueue.main.async {
                self?.totalFeeLabel.text = text
            }
        }
        
        viewModel.totalFeeAmountText = { [weak self] text in
            DispatchQueue.main.async {
                self?.totalFeeAmountLabel.text = text
            }
        }
        
        viewModel.arrivalTimeText = { [weak self] text in
            DispatchQueue.main.async {
                self?.arrivalTimeLabel.text = text
            }
        }
        
        viewModel.estimatedTimeArrival = { [weak self] text in
            DispatchQueue.main.async {
                self?.estimatedTimeArrivalLabel.text = text
            }
        }
        
        viewModel.confirmText = { [weak self] text in
            DispatchQueue.main.async {
                self?.confirmButton.setTitle(text, for: .normal)
            }
        }
    }
    
    // MARK: - Actions
    
    @IBAction private func didPressConfirmButton(_ sender: UIButton) {
//        viewModel.didPressConfirm(deposit: deposit)
    }
}
