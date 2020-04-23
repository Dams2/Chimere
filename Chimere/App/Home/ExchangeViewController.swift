//
//  HomeViewController.swift
//  antex
//
//  Created by Damien Rojo on 14.04.20.
//  Copyright © 2020 Damien Rojo. All rights reserved.
//

import UIKit

final class ExchangeViewController: UIViewController {
    
    // MARK: - Private Properties

    var viewModel: ExchangeViewModel!

    // MARK: - Outlets

    @IBOutlet weak private var descriptionTextView: UITextView! {
        didSet {
            descriptionTextView.backgroundColor = .white
        }
    }

    // Deposit //

    @IBOutlet weak private var originView: UIView! {
        didSet {
            originView.backgroundColor = .white
            originView.layer.borderWidth = 1
            originView.layer.borderColor = #colorLiteral(red: 0.9294117647, green: 0.9490196078, blue: 0.968627451, alpha: 1)
            originView.layer.cornerRadius = 10
        }
    }

    @IBOutlet weak private var originLabel: UILabel!

    @IBOutlet weak private var originAmountTextField: UITextField! {
        didSet {
            originAmountTextField.keyboardType = .decimalPad
            originAmountTextField.backgroundColor = .white
        }
    }

    @IBOutlet weak private var originCurrencyView: UIView! {
        didSet {
            originCurrencyView.layer.cornerRadius = 10
        }
    }

    @IBOutlet weak private var originCurrencyNameLabel: UILabel!

    @IBOutlet weak private var originCurrencySymbolLabel: UILabel!

    @IBOutlet weak private var changeOriginCurrencyButton: UIButton!

    @IBOutlet weak private var refundAddressTextField: UITextField!

    // Info //

    @IBOutlet weak private var infoView: UIView!

    @IBOutlet weak private var exchangeRateLabel: UILabel!

    @IBOutlet weak private var switchButton: UIButton! {
        didSet {
            switchButton.layer.cornerRadius = 28
        }
    }

    // Destination //

    @IBOutlet weak private var destinationView: UIView! {
        didSet {
            destinationView.backgroundColor = .white
            destinationView.layer.borderWidth = 1
            destinationView.layer.borderColor = #colorLiteral(red: 0.9294117647, green: 0.9490196078, blue: 0.968627451, alpha: 1)
            destinationView.layer.cornerRadius = 10
        }
    }

    @IBOutlet weak private var destinationLabel: UILabel!

    @IBOutlet weak private var destinationAmountTextField: UITextField! {
        didSet {
            destinationAmountTextField.keyboardType = .decimalPad
            destinationAmountTextField.backgroundColor = .white
            destinationAmountTextField.isUserInteractionEnabled = false
        }
    }

    @IBOutlet weak private var destinationCurrencyView: UIView! {
        didSet {
            destinationCurrencyView.layer.cornerRadius = 10
        }
    }

    @IBOutlet weak private var destinationCurrencyNameLabel: UILabel!

    @IBOutlet weak private var destinationCurrencySymbolLabel: UILabel!

    @IBOutlet weak private var changeDestinationCurrencyButton: UIButton!

    @IBOutlet weak private var destinationAddressTextField: UITextField!

    @IBOutlet weak private var exchangeNowButton: UIButton! {
        didSet {
            exchangeNowButton.layer.cornerRadius = 10
        }
    }

    // MARK: - View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        self.tabBarController?.tabBar.barTintColor = .white
        self.tabBarController?.tabBar.tintColor = #colorLiteral(red: 1, green: 0.4872516394, blue: 0.8796543479, alpha: 1)
        bind(to: viewModel)
        viewModel.viewDidLoad()
    }
    
    // MARK: - Helpers
    
    private func bind(to viewModel: ExchangeViewModel) {
        
        viewModel.descriptionText = { [weak self] text in
            DispatchQueue.main.async {
                self?.descriptionTextView.text = text
            }
        }
        
        viewModel.originText = { [weak self] text in
            DispatchQueue.main.async {
                self?.originLabel.text = text
            }
        }
        
        viewModel.originAmountText = { [weak self] placeholder in
            DispatchQueue.main.async {
                self?.originAmountTextField.placeholder = placeholder
            }
        }
        
        viewModel.originCurrencyNameText = { [weak self] text in
            DispatchQueue.main.async {
                self?.originCurrencyNameLabel.text = text
            }
        }
        
        viewModel.originCurrencySymbolText = { [weak self] text in
            DispatchQueue.main.async {
                self?.originCurrencySymbolLabel.text = text
            }
        }
        
        viewModel.refundAddressText = { [weak self] placeholder in
            DispatchQueue.main.async {
                self?.refundAddressTextField.placeholder = placeholder
            }
        }
        
        viewModel.exchangeRatesText = { [weak self] text in
            DispatchQueue.main.async {
                self?.exchangeRateLabel.text = text
            }
        }
        
        viewModel.destinationText = { [weak self] text in
            DispatchQueue.main.async {
                self?.destinationLabel.text = text
            }
        }
        
        viewModel.destinationAmountText = { [weak self] placeholder in
            DispatchQueue.main.async {
                self?.destinationAmountTextField.placeholder = placeholder
            }
        }
        
        viewModel.destinationCurrencyNameText = { [weak self] text in
            DispatchQueue.main.async {
                self?.destinationCurrencyNameLabel.text = text
            }
        }
        
        viewModel.destinationCurrencySymbolText = { [weak self] text in
            DispatchQueue.main.async {
                self?.destinationCurrencySymbolLabel.text = text
            }
        }
        
        viewModel.destinationAddressText = { [weak self] placeholder in
            DispatchQueue.main.async {
                self?.destinationAddressTextField.placeholder = placeholder
            }
        }
        
        viewModel.exchangeNowText = { [weak self] text in
            DispatchQueue.main.async {
                self?.exchangeNowButton.setTitle(text, for: .normal)
            }
        }
    }
    
    private func changePLaceholderColor(refundAddressText: String, destinationAddressText: String) {
        if refundAddressText.isEmpty && destinationAddressText.isEmpty {
            changePlaceholder(addressTextField: refundAddressTextField, message: "You must fill refund address")
        } else if destinationAddressText.isEmpty {
            changePlaceholder(addressTextField: destinationAddressTextField, message: "You must fill destination address")
        }
    }

    private func changePlaceholder(addressTextField: UITextField, message: String) {
        addressTextField.attributedPlaceholder = NSAttributedString(string: message,
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
        
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: addressTextField.frame.height - 1, width: addressTextField.frame.width, height: 1.0)
        bottomLine.backgroundColor = UIColor.red.cgColor
        addressTextField.layer.addSublayer(bottomLine)
    }

    // MARK: - Actions

    @IBAction func didPressChangeOriginCurrencyButton(_ sender: UIButton) {
        viewModel.didPressChangeOriginCurrency() 
    }

    @IBAction func didPressSwitchButton(_ sender: UIButton) {
        viewModel.didPressSwitch()
    }

    @IBAction func didPressChangeDestinationCurrencyButton(_ sender: UIButton) {
        viewModel.didPressChangeDestinationCurrency()
    }

    @IBAction func didPressExchangeNowButton(_ sender: UIButton) {
        guard let refundAddressText = refundAddressTextField.text, let destinationAddressText = destinationAddressTextField.text else { return }
                
        changePLaceholderColor(refundAddressText: refundAddressText, destinationAddressText: destinationAddressText)
        
        guard let depositCurrencySymbolText = originCurrencySymbolLabel.text, let destinationCurrencySymbolText = destinationCurrencySymbolLabel.text else { return }
        
        viewModel.didPressExchangeNow(depositCurrencySymbolText: depositCurrencySymbolText, refundAddressText: refundAddressText, destinationCurrencySymbolText: destinationCurrencySymbolText, destinationAddressText: destinationAddressText)
    }

    // MARK: - Public

    func updateOrigin(currency: Currency) {
        viewModel.updateOrigin(currency: currency)
    }

    func updateDestination(currency: Currency) {
        viewModel.updateDestination(currency: currency)
    }
}
