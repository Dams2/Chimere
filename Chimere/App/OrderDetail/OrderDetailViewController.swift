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
    
    @IBOutlet weak private var statusView: UIView! {
        didSet {
            statusView.layer.cornerRadius = 10
            statusView.layer.borderWidth = 1
            statusView.layer.borderColor = #colorLiteral(red: 0.9490196078, green: 0.862745098, blue: 0.6078431373, alpha: 1)
        }
    }
    
    @IBOutlet weak private var statusLabel: UILabel!
    
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
    
    // State
    
    @IBOutlet weak private var stateDescriptionView: UIView!
    
    @IBOutlet weak private var paidImageView: UIImageView!
    
    @IBOutlet weak private var paidLabel: UILabel!
    
    @IBOutlet weak private var exchangingImageView: UIImageView!
    
    @IBOutlet weak private var exchangingLabel: UILabel!
    
    @IBOutlet weak private var exchangedImageView: UIImageView!
    
    @IBOutlet weak private var exchangedLabel: UILabel!
    
    @IBOutlet weak private var sendingImageView: UIImageView!
    
    @IBOutlet weak private var sendingLabel: UILabel!
    
    @IBOutlet weak private var completedImageView: UIImageView!
    
    @IBOutlet weak private var completedLabel: UILabel!
    
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
                DispatchQueue.main.async {
                    self?.statusLabel.textColor = #colorLiteral(red: 0.9490196078, green: 0.1137254902, blue: 0.1137254902, alpha: 1)
                    self?.depositWalletView.isHidden = true
                    self?.stateDescriptionView.isHidden = true
                }
            case .loaded:
                DispatchQueue.main.async {
                    self?.statusLabel.textColor = #colorLiteral(red: 0.3529411765, green: 0.4509803922, blue: 0.007843137255, alpha: 1)
                    self?.depositWalletView.isHidden = true
                    self?.stateDescriptionView.isHidden = false
                }
            case .exchanging:
                DispatchQueue.main.async {
                    self?.statusLabel.textColor = #colorLiteral(red: 0.3529411765, green: 0.4509803922, blue: 0.007843137255, alpha: 1)
                    self?.exchangingImageView.tintColor = #colorLiteral(red: 0.3529411765, green: 0.4509803922, blue: 0.007843137255, alpha: 1)
                    self?.exchangingLabel.textColor = #colorLiteral(red: 0.3529411765, green: 0.4509803922, blue: 0.007843137255, alpha: 1)
                }
            case .exchanged:
                DispatchQueue.main.async {
                    self?.statusLabel.textColor = #colorLiteral(red: 0.3529411765, green: 0.4509803922, blue: 0.007843137255, alpha: 1)
                    self?.exchangedImageView.tintColor = #colorLiteral(red: 0.3529411765, green: 0.4509803922, blue: 0.007843137255, alpha: 1)
                    self?.exchangedLabel.textColor = #colorLiteral(red: 0.3529411765, green: 0.4509803922, blue: 0.007843137255, alpha: 1)
                }
            case .sending:
                DispatchQueue.main.async {
                    self?.statusLabel.textColor = #colorLiteral(red: 0.3529411765, green: 0.4509803922, blue: 0.007843137255, alpha: 1)
                    self?.sendingImageView.tintColor = #colorLiteral(red: 0.3529411765, green: 0.4509803922, blue: 0.007843137255, alpha: 1)
                    self?.sendingLabel.textColor = #colorLiteral(red: 0.3529411765, green: 0.4509803922, blue: 0.007843137255, alpha: 1)
                }
            case .completed:
                DispatchQueue.main.async {
                    self?.statusLabel.textColor = #colorLiteral(red: 0.3529411765, green: 0.4509803922, blue: 0.007843137255, alpha: 1)
                    self?.completedImageView.tintColor = #colorLiteral(red: 0.3529411765, green: 0.4509803922, blue: 0.007843137255, alpha: 1)
                    self?.completedLabel.textColor = #colorLiteral(red: 0.3529411765, green: 0.4509803922, blue: 0.007843137255, alpha: 1)
                }
            case .expired:
                DispatchQueue.main.async {
                    self?.statusLabel.textColor = #colorLiteral(red: 0.9490196078, green: 0.1137254902, blue: 0.1137254902, alpha: 1)
                    self?.depositWalletView.isHidden = true
                    self?.stateDescriptionView.isHidden = true
                }
            case .notPaid:
                DispatchQueue.main.async {
                    self?.statusLabel.textColor = #colorLiteral(red: 0.9490196078, green: 0.862745098, blue: 0.6078431373, alpha: 1)
                    self?.depositWalletView.isHidden = false
                    self?.stateDescriptionView.isHidden = true
                }
            }
        }
        
        viewModel.statusText = { [weak self] text in
            DispatchQueue.main.async {
                self?.statusLabel.text = text
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
        
        // State

        viewModel.paidImageText = { [weak self] text in
            DispatchQueue.main.async {
                self?.paidImageView.image = UIImage(systemName: text)
            }
        }
        
        viewModel.paidText = { [weak self] text in
            DispatchQueue.main.async {
                self?.paidLabel.text = text
            }
        }
        
        viewModel.exchangingImageText = { [weak self] text in
            DispatchQueue.main.async {
                self?.exchangingImageView.image = UIImage(systemName: text)
            }
        }
        
        viewModel.exchangingText = { [weak self] text in
            DispatchQueue.main.async {
                self?.exchangingLabel.text = text
            }
        }
        
        viewModel.exchangedImageText = { [weak self] text in
            DispatchQueue.main.async {
                self?.exchangedImageView.image = UIImage(systemName: text)
            }
        }
        
        viewModel.exchangedText = { [weak self] text in
            DispatchQueue.main.async {
                self?.exchangedLabel.text = text
            }
        }
        
        viewModel.sendingImageText = { [weak self] text in
            DispatchQueue.main.async {
                self?.sendingImageView.image = UIImage(systemName: text)
            }
        }
        
        viewModel.sendingText = { [weak self] text in
            DispatchQueue.main.async {
                self?.sendingLabel.text = text
            }
        }
        
        viewModel.completedImageText = { [weak self] text in
            DispatchQueue.main.async {
                self?.completedImageView.image = UIImage(systemName: text)
            }
        }
        
        viewModel.completedText = { [weak self] text in
            DispatchQueue.main.async {
                self?.completedLabel.text = text
            }
        }
        
        // Wallet
        
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
