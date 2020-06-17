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
            statusView.layer.borderWidth = 1
            statusView.layer.borderColor = #colorLiteral(red: 0.9490196078, green: 0.862745098, blue: 0.6078431373, alpha: 1)
        }
    }
    
    @IBOutlet weak private var statusLabel: UILabel!

    @IBOutlet weak private var statusStep1Label: UILabel!
    
    @IBOutlet weak private var statusStep1ImageView: UIImageView!
    
    @IBOutlet weak private var statusStep2Label: UILabel!
    
    @IBOutlet weak private var statusStep2ImageView: UIImageView!
    
    @IBOutlet weak private var statusStep3Label: UILabel!
    
    @IBOutlet weak private var statusStackView: UIStackView!
    
    @IBOutlet weak private var transactionIDView: UIView!
    
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
    
    @IBOutlet weak private var destinationAddressLabel: UILabel!
    
    @IBOutlet weak private var destinationAddressValueLabel: UILabel!
    
    @IBOutlet weak private var dateLabel: UILabel!
    
    // Wallet
    
    @IBOutlet weak private var depositWalletView: UIView! {
        didSet {
            depositWalletView.layer.borderWidth = 1
            depositWalletView.layer.borderColor = #colorLiteral(red: 0.9490196078, green: 0.862745098, blue: 0.6078431373, alpha: 1)
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
            case .failed:
                self?.statusLabel.textColor = #colorLiteral(red: 0.9490196078, green: 0.1137254902, blue: 0.1137254902, alpha: 1)
                self?.depositWalletView.isHidden = true
                self?.statusStackView.isHidden = true
                self?.statusLabel.isHidden = false
            case .loaded:
                self?.statusStep1Label.textColor = #colorLiteral(red: 0.3529411765, green: 0.4509803922, blue: 0.007843137255, alpha: 1)
                self?.statusStep1ImageView.tintColor = #colorLiteral(red: 0.3529411765, green: 0.4509803922, blue: 0.007843137255, alpha: 1)
                self?.depositWalletView.isHidden = true
                self?.statusStackView.isHidden = false
                self?.statusLabel.isHidden = true
            case .exchanging:
                self?.statusStep2Label.textColor = #colorLiteral(red: 0.3529411765, green: 0.4509803922, blue: 0.007843137255, alpha: 1)
                self?.statusStep2ImageView.tintColor = #colorLiteral(red: 0.3529411765, green: 0.4509803922, blue: 0.007843137255, alpha: 1)
            case .completed:
                self?.statusStep3Label.textColor = #colorLiteral(red: 0.3529411765, green: 0.4509803922, blue: 0.007843137255, alpha: 1)
            case .expired:
                self?.statusLabel.textColor = #colorLiteral(red: 0.9490196078, green: 0.1137254902, blue: 0.1137254902, alpha: 1)
                self?.depositWalletView.isHidden = true
                self?.statusStackView.isHidden = true
            case .notPaid:
                self?.statusLabel.textColor = #colorLiteral(red: 0.9490196078, green: 0.862745098, blue: 0.6078431373, alpha: 1)
                self?.statusStackView.isHidden = true
            }
        }
        
        viewModel.statusText = { [weak self] text in
            DispatchQueue.main.async {
                self?.statusLabel.text = text
            }
        }
        
        viewModel.statusStep1Text = { [weak self] text in
            DispatchQueue.main.async {
                self?.statusStep1Label.text = text
            }
        }
        
        viewModel.statusStep1ImageText = { [weak self] text in
            DispatchQueue.main.async {
                self?.statusStep1ImageView.image = UIImage(systemName: text)
            }
        }
        
        viewModel.statusStep2Text = { [weak self] text in
            DispatchQueue.main.async {
                self?.statusStep2Label.text = text
            }
        }
        
        viewModel.statusStep2ImageText = { [weak self] text in
            DispatchQueue.main.async {
                self?.statusStep2ImageView.image = UIImage(systemName: text)
            }
        }
        
        viewModel.statusStep3Text = { [weak self] text in
            DispatchQueue.main.async {
                self?.statusStep3Label.text = text
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
        
        viewModel.destinationAddressText = { [weak self] text in
            DispatchQueue.main.async {
                self?.destinationAddressLabel.text = text
            }
        }

        viewModel.destinationAddressValueText = { [weak self] text in
            DispatchQueue.main.async {
                self?.destinationAddressValueLabel.text = text
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
        helper.copyNotified(button: sender, label: transactionIDValueLabel, bool: false)
    }
    
    @IBAction private func didPressCopyDepositAmountButton(_ sender: UIButton) {
        helper.copyNotified(button: sender, label: depositAmountLabel, bool: true)
    }
    
    @IBAction private func didPressCopyDepositAddressButton(_ sender: UIButton) {
        helper.copyNotified(button: sender, label: depositAddressLabel, bool: false)
    }
    
    
    @IBAction private func didPressCopyMessageValueButton(_ sender: UIButton) {
        helper.copyNotified(button: sender, label: messageValueLabel, bool: false)
    }
}
