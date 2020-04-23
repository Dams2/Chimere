//
//  DepositViewController.swift
//  antex
//
//  Created by Damien Rojo on 15.04.20.
//  Copyright © 2020 Damien Rojo. All rights reserved.
//

import UIKit

final class DepositViewController: UIViewController {
    
    // MARK: - Properties
    
    var viewModel: DepositViewModel!
    
    // MARK: - Outlets
  
        
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak private var transactionIDView: UIView! {
        didSet {
            transactionIDView.backgroundColor = .white
            transactionIDView.layer.cornerRadius = 15
        }
    }
    
    @IBOutlet weak private var transactionIDLabel: UILabel!
    
    @IBOutlet weak private var transactionIDValueLabel: UILabel!
    
    @IBOutlet weak private var copyTansactionIDButton: UIButton!
    
    @IBOutlet weak private var descriptionLabel: UITextView!
    
    @IBOutlet weak private var depositWallet: UIView! {
        didSet {
            depositWallet.backgroundColor = .white
            depositWallet.layer.cornerRadius = 15
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
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind(to: viewModel)
        viewModel.viewDidLoad()
    }
    
    // MARK: - Helpers
    
    private func bind(to viewModel: DepositViewModel) {
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
                self?.copyTansactionIDButton.setBackgroundImage(UIImage(systemName: text), for: .normal)
            }
        }
        
        viewModel.descriptionText = { [weak self] text in
            DispatchQueue.main.async {
                self?.descriptionLabel.text = text
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
        
        viewModel.copyDepositAmountImageText = { [weak self] text in
            DispatchQueue.main.async {
                self?.copyDepositAmountButton.setImage(UIImage(systemName: text), for: .normal)
            }
        }
        
        viewModel.toThisWalletText = { [weak self] text in
            DispatchQueue.main.async {
                self?.toThisWalletLabel.text = text
            }
        }
        
        viewModel.depositQRCodeText = {  text in
            DispatchQueue.main.async {
                guard let image = self.generateQRCode(from: text) else { return }
                self.depositQRCodeImageView.image = image
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
        
        viewModel.copyDepositAdressImageText = { [weak self] text in
            DispatchQueue.main.async {
                self?.copyDepositAdressButton.setImage(UIImage(systemName: text), for: .normal)
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
        
        viewModel.copyMessageValueImageText = { [weak self] text in
            DispatchQueue.main.async {
                self?.copyMessageValueButton.setImage(UIImage(systemName: text), for: .normal)
            }
        }
    }
    
    private func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)

        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)

            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }

        return nil
    }
    
    private func copyNotified(button: UIButton, label: UILabel) {
        UIPasteboard.general.string = label.text
        button.setBackgroundImage(UIImage(systemName: "checkmark.seal"), for: .normal)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            button.setBackgroundImage(UIImage(systemName: "square.on.square"), for: .normal)
        }
    }
    
    // MARK: - Actions
    
    @IBAction private func didPressCopyTransactionIDButton(_ sender: UIButton) {
        copyNotified(button: sender, label: transactionIDValueLabel)
    }
    
    @IBAction private func didPressCopyDepositAmountButton(_ sender: UIButton) {
        copyNotified(button: sender, label: depositAmountLabel)
    }
    
    @IBAction private func didPressCopyDepositAdressButton(_ sender: UIButton) {
        copyNotified(button: sender, label: depositAddressLabel)
    }
    
    @IBAction private func didPressCopyMessageValueButton(_ sender: UIButton) {
        copyNotified(button: sender, label: messageValueLabel)
    }
}
