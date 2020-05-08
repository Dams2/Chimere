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
    
    @IBOutlet weak private var depositAmountLabel: UILabel!
    
    @IBOutlet weak private var copyDepositAmountButton: UIButton!
    
    @IBOutlet weak private var toThisWalletLabel: UILabel!
    
    @IBOutlet weak private var depositQRCodeImageView: UIImageView!
    
    @IBOutlet weak private var addressLabel: UILabel!
    
    @IBOutlet weak private var depositAddressLabel: UILabel!
    
    @IBOutlet weak private var copyDepositAdressButton: UIButton!
    
    @IBOutlet weak private var messageLabel: UILabel! {
       didSet {
           messageLabel.isHidden = true
       }
    }
    
    @IBOutlet weak private var messageValueLabel: UILabel! {
       didSet {
           messageValueLabel.isHidden = true
       }
    }
    
    @IBOutlet weak private var copyMessageValueButton: UIButton! {
        didSet {
            copyMessageValueButton.isHidden = true
        }
    }
    
    // MARK: - Actions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind(to: viewModel)
        viewModel.viewDidLoad()
    }
    
    // MARK: - Helpers
    
    func bind(to viewModel: OrderDetailViewModel) {
        viewModel.status = { [weak self] state in
            switch state {
            case .paid:
                self?.depositWalletView.isHidden = true
            case .notPaid:
                self?.depositWalletView.isHidden = false
            }
        }
        
        viewModel.statusText = { [weak self] text in
            DispatchQueue.main.async {
                self?.statusLabel.text = text
                guard let statusLabel = self?.statusLabel else { return }
                self?.helper.colorCode(state: text, text: statusLabel)
            }
        }

        viewModel.transactionIDText = { [weak self] text in
            DispatchQueue.main.async {
                self?.transactionIDLabel.text = text
            }
        }

        viewModel.transactionIDValueText = { [weak self] text in
            DispatchQueue.main.async {
                self?.transactionIDValueLabel.text = text
            }
        }

        viewModel.copyTansactionIDImageText = { [weak self] text in
            DispatchQueue.main.async {
                self?.copyTransactionIDValueButton.setBackgroundImage(UIImage(systemName: text), for: .normal)
            }
        }

        viewModel.originCurrencyImageText = { [weak self] text in
            DispatchQueue.main.async {
                self?.originCurrencyImageView.image = UIImage(named: text)
            }
        }

        viewModel.originAmountText = { [weak self] text in
            DispatchQueue.main.async {
                self?.originAmountLabel.text = text
            }
        }

        viewModel.originCurrencySymbolText = { [weak self] text in
            DispatchQueue.main.async {
                self?.originCurrencySymbolLabel.text = text
            }
        }

        viewModel.toImageText = { [weak self] text in
            DispatchQueue.main.async {
                self?.toImageView.image = UIImage(systemName: text)
            }
        }

        viewModel.destinationCurrencyImageText = { [weak self] text in
            DispatchQueue.main.async {
                self?.destinationCurrencyImageView.image = UIImage(named: text)
            }
        }

        viewModel.destinationAmountText = { [weak self] text in
            DispatchQueue.main.async {
                self?.destinationAmountLabel.text = text
            }
        }

        viewModel.destinationCurrencySymbolText = { [weak self] text in
            DispatchQueue.main.async {
                self?.destinationCurrencySymbolLabel.text = text
            }
        }

        viewModel.dateText = { [weak self] text in
            DispatchQueue.main.async {
                self?.dateLabel.text = text
            }
        }
        
        viewModel.sendText = { [weak self] text in
            DispatchQueue.main.async {
                self?.sendLabel.text = text
            }
        }
        
        viewModel.depositAmountText = { [weak self] text in
            DispatchQueue.main.async {
                self?.depositAmountLabel.text = text
            }
        }
        
        viewModel.copyDepositAmountImageText  = { [weak self] text in
            DispatchQueue.main.async {
                self?.copyDepositAmountButton.setBackgroundImage(UIImage(systemName: text), for: .normal)
            }
        }
        
        viewModel.toThisWalletText = { [weak self] text in
            DispatchQueue.main.async {
                self?.toThisWalletLabel.text = text
            }
        }
        
        viewModel.depositQRCodeImageText = { [weak self] text in
            DispatchQueue.main.async {
                guard let image = self?.helper.generateQRCode(from: text) else { return }
                self?.depositQRCodeImageView.image = image
            }
        }
        
        viewModel.addressText = { [weak self] text in
            DispatchQueue.main.async {
                self?.addressLabel.text = text
            }
        }
        
        viewModel.depositAddressText = { [weak self] text in
            DispatchQueue.main.async {
                self?.depositAddressLabel.text = text
            }
        }
        
        viewModel.copyDepositAdressImageText  = { [weak self] text in
            DispatchQueue.main.async {
                self?.copyDepositAdressButton.setBackgroundImage(UIImage(systemName: text), for: .normal)
            }
        }
        
        viewModel.messageText = { [weak self] text in
            DispatchQueue.main.async {
                self?.messageLabel.text = text
            }
        }
        
        viewModel.messageValueText = { [weak self] text in
            DispatchQueue.main.async {
                self?.messageValueLabel.text = text
            }
        }
        
        viewModel.copyMessageValueImageText  = { [weak self] text in
            DispatchQueue.main.async {
                self?.copyMessageValueButton.setBackgroundImage(UIImage(systemName: text), for: .normal)
            }
        }
    }

    @IBAction private func didPressCopyTransactionIDValueButton(_ sender: UIButton) {
        helper.copyNotified(button: sender, label: transactionIDValueLabel)
    }
    
    @IBAction private func didPressCopyDepositAmountButton(_ sender: UIButton) {
        helper.copyNotified(button: sender, label: depositAmountLabel)
    }
    
    @IBAction private func didPressCopyDepositAddressButton(_ sender: UIButton) {
        helper.copyNotified(button: sender, label: depositAddressLabel)
    }
    
    
    @IBAction private func didPressCopyMessageValueButton(_ sender: UIButton) {
        helper.copyNotified(button: sender, label: messageValueLabel)
    }
}
