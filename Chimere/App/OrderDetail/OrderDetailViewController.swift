//
//  OrderDetailViewController.swift
//  Chimere
//
//  Created by Damien Rojo on 30.04.20.
//  Copyright © 2020 Damien Rojo. All rights reserved.
//

import UIKit

final class OrderDetailViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private let helper = Helper()
    
    // MARK: - Properties
    
    var viewModel: OrderDetailViewModel!
    
    // MARK: - Outlets
    
    @IBOutlet private weak var statusView: UIView! {
        didSet {
            statusView.layer.cornerRadius = 10
        }
    }
    
    @IBOutlet weak private var statusLabel: UILabel!
    
    @IBOutlet weak private var transactionIDLabel: UILabel!
    
    @IBOutlet weak private var transactionIDValueLabel: UILabel!
    
    @IBOutlet weak private var copyTransactionIDValueButton: UIButton!
    
    @IBOutlet weak private var originCurrencyImageView: UIImageView!
    
    @IBOutlet weak private var originAmountLabel: UILabel!
    
    @IBOutlet weak private var originCurrencySymbolLabel: UILabel!
    
    @IBOutlet weak private var toImageView: UIImageView!
    
    @IBOutlet weak private var destinationCurrencyImageView: UIImageView!
    
    @IBOutlet weak private var destinationAmountLabel: UILabel!
    
    @IBOutlet weak private var destinationCurrencySymbolLabel: UILabel!
    
    @IBOutlet weak private var dateLabel: UILabel!
    
    // Wallet
    
    @IBOutlet weak private var depositWalletView: UIView! {
        didSet {
            depositWalletView.layer.borderWidth = 1
            depositWalletView.layer.borderColor = #colorLiteral(red: 0.9294117647, green: 0.9490196078, blue: 0.968627451, alpha: 1)
            depositWalletView.layer.cornerRadius = 15
        }
    }
    
    @IBOutlet weak private var sendLabel: UILabel!
    
    @IBOutlet weak private  var depositAmountLabel: UILabel!
    
    @IBOutlet weak private var copyDepositAmountButton: UIButton!
    
    @IBOutlet weak private var toThisWalletLabel: UILabel!
    
    @IBOutlet weak private var depositQRCodeImageView: UIImageView!
    
    @IBOutlet weak private var addressLabel: UILabel!
    
    @IBOutlet weak private var depositAddressLabel: UILabel!
    
    @IBOutlet weak private var copyDepositAdressButton: UIButton!
    
    @IBOutlet weak private var messageLabel: UILabel!
    
    @IBOutlet weak private var messageValueLabel: UILabel!
    
    @IBOutlet weak private var copyMessageValueButton: UIButton!
    
    // MARK: - Actions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind(to: viewModel)
        viewModel.viewDidLoad()
        
        setState()
    }
    
    // MARK: - Helpers
    
    func bind(to viewModel: OrderDetailViewModel) {
        viewModel.statusText = { [weak self] text in
            self?.statusLabel.text = text
        }
        
        viewModel.transactionIDText = { [weak self] text in
            self?.transactionIDLabel.text = text
        }
        
        viewModel.transactionIDValueText = { [weak self] text in
            self?.transactionIDValueLabel.text = text
        }
        
        viewModel.copyTansactionIDImageText = { [weak self] text in
            self?.copyTransactionIDValueButton.setImage(UIImage(systemName: text), for: .normal)
        }
        
        viewModel.originCurrencyImageText = { [weak self] text in
            self?.originCurrencyImageView.image = UIImage(named: text)
        }
        
        viewModel.originAmountText = { [weak self] text in
            self?.originAmountLabel.text = text
        }
        
        viewModel.originCurrencySymbolText = { [weak self] text in
            self?.originCurrencySymbolLabel.text = text
        }
        
        viewModel.toImageText = { [weak self] text in
            self?.toImageView.image = UIImage(systemName: text)
        }
        
        viewModel.destinationCurrencyImageText = { [weak self] text in
            self?.destinationCurrencyImageView.image = UIImage(named: text)
        }
        
        viewModel.destinationAmountText = { [weak self] text in
            self?.destinationAmountLabel.text = text
        }
        
        viewModel.destinationCurrencySymbolText = { [weak self] text in
            self?.destinationCurrencySymbolLabel.text = text
        }
        
        viewModel.dateText = { [weak self] text in
            self?.dateLabel.text = text
        }
    }
    
    private func setState() {
        guard let state = statusLabel.text else { return }
        helper.colorCode(state: state, text: statusLabel)
    }
    
    @IBAction private func didPressCopyTransactionIDValueButton(_ sender: UIButton) {
        helper.copyNotified(button: sender, label: transactionIDValueLabel)
    }
}
