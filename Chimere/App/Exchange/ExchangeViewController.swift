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
    
    // Warning //
    
    @IBOutlet weak private var warningImageView: UIImageView!
    
    @IBOutlet weak private var warningLabel: UILabel!
    
    @IBOutlet weak private var warningAmountButton: UIButton!

    @IBOutlet weak private var moonPaybutton: UIButton!
    
    @IBOutlet weak private var exchangeNowButton: UIButton! {
        didSet {
            exchangeNowButton.layer.cornerRadius = 10
            exchangeNowButton.layer.borderWidth = 1
            exchangeNowButton.layer.borderColor = #colorLiteral(red: 0.9294117647, green: 0.9490196078, blue: 0.968627451, alpha: 1)
        }
    }

    // MARK: - View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        setUI()
        bind(to: viewModel)
        viewModel.viewDidLoad()
    }

    // MARK: - Helpers
    
    private func setUI() {
        let imageView = UIImageView(frame: CGRect(x: -40, y: 0, width: 40, height: 40))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "Chimere")
        imageView.image = image
        self.navigationItem.titleView = imageView
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.tabBarController?.tabBar.barTintColor = .white
        self.tabBarController?.tabBar.tintColor = #colorLiteral(red: 1, green: 0.4872516394, blue: 0.8796543479, alpha: 1)
    }

    private func bind(to viewModel: ExchangeViewModel) {
        
        viewModel.loadingState = { [weak self] state in
            DispatchQueue.main.async {
                self?.switchButton.layer.backgroundColor = state ? #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1) : #colorLiteral(red: 1, green: 0.4872516394, blue: 0.8796543479, alpha: 1)
                switch state {
                case true:
                    self?.switchButton.isEnabled = false
                case false:
                    self?.switchButton.isEnabled = true
                }
            }
        }

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

        viewModel.originAmountPlaceholderText = { [weak self] placeholder in
            DispatchQueue.main.async {
                self?.originAmountTextField.placeholder = placeholder
            }
        }

        viewModel.originAmountText = { [weak self] text in
            DispatchQueue.main.async {
                self?.originAmountTextField.text = text
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

        viewModel.exchangeRateText = { [weak self] text in
            DispatchQueue.main.async {
                self?.exchangeRateLabel.text = text
            }
        }

        viewModel.destinationText = { [weak self] text in
            DispatchQueue.main.async {
                self?.destinationLabel.text = text
            }
        }

        viewModel.destinationAmountPlaceholderText = { [weak self] placeholder in
            DispatchQueue.main.async {
                self?.destinationAmountTextField.placeholder = placeholder
            }
        }

        viewModel.destinationAmountText = { [weak self] text in
            DispatchQueue.main.async {
                self?.destinationAmountTextField.text = text
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

        viewModel.warningImageText = { [weak self] text in
            DispatchQueue.main.async {
                self?.warningImageView.image = UIImage(systemName: text)
            }
        }

        viewModel.warningText = { [weak self] text in
            DispatchQueue.main.async {
                self?.warningLabel.text = text
            }
        }

        viewModel.warningAmountText = { [weak self] text in
            DispatchQueue.main.async {
                self?.warningAmountButton.setTitle(text, for: .normal)
            }
        }

        viewModel.exchangeNowText = { [weak self] text in
            DispatchQueue.main.async {
                self?.exchangeNowButton.setTitle(text, for: .normal)
            }
        }
        
        viewModel.alertState = { [weak self] state in
            DispatchQueue.main.async {
                switch state {
                case true:
                    self?.warningAmountButton.isEnabled = false
                default:
                    self?.warningAmountButton.isEnabled = true
                }
            }
        }
    }

    private func changePLaceholderColor(refundAddressText: String, destinationAddressText: String) {
        if destinationAddressText.isEmpty {
            changePlaceholder(addressTextField: destinationAddressTextField)
        }
    }

    private func changePlaceholder(addressTextField: UITextField) {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: addressTextField.frame.height - 1, width: addressTextField.frame.width, height: 1.0)
        bottomLine.backgroundColor = UIColor.red.cgColor
        addressTextField.layer.addSublayer(bottomLine)
    }

    // MARK: - Actions

    @IBAction private func originAmountTextFieldDidChange(_ sender: UITextField) {
        guard let originAmountText = originAmountTextField.text else { return }
        let strReplace = originAmountText.replacingOccurrences(of: ",", with: ".", options: .literal, range: nil)
        sender.text = strReplace 
        viewModel.getRates(originAmountText: strReplace)
    }

    @IBAction private func didPressChangeOriginCurrencyButton(_ sender: UIButton) {
        viewModel.didPressChangeOriginCurrency() 
    }

    @IBAction private  func didPressSwitchButton(_ sender: UIButton) {
        guard let originAmountText = originAmountTextField.text else { return}
        
        
        viewModel.didPressSwitch(originAmountText: originAmountText)
    }

    @IBAction private func didPressChangeDestinationCurrencyButton(_ sender: UIButton) {
        viewModel.didPressChangeDestinationCurrency()
    }

    @IBAction private func didPressWarningAmountButton(_ sender: UIButton) {
        guard let warningAmountText = sender.titleLabel?.text,
            let originAmountText = originAmountTextField.text
            else { return }

        viewModel.didPressWarningAmount(warningAmountText: warningAmountText, originAmount: originAmountText)
    }
    
    
    @IBAction private func didPressMoonPayButton(_ sender: UIButton) {
        guard let url = URL(string: viewModel.didPressMoonPay()) else { return }
        UIApplication.shared.open(url)
    }
    
    @IBAction private func didPressExchangeNowButton(_ sender: UIButton) {
        guard let originAmount = originAmountTextField.text,
            let refundAddressText = refundAddressTextField.text,
            let destinationAddressText = destinationAddressTextField.text
            else { return }
        
        
        guard let userID = UIDevice.current.identifierForVendor?.uuidString,
        let originAmountText = originAmountTextField.text,
        let destinationAmountText = destinationAmountTextField.text,
        let exchangeRate = exchangeRateLabel.text
        else { return }
        
        if !originAmount.isEmpty {
            changePLaceholderColor(refundAddressText: refundAddressText, destinationAddressText: destinationAddressText)
        }

        viewModel.didPressExchangeNow(userID: userID,
                                      originAmountText: originAmountText,
                                      refundAddressText: refundAddressText,
                                      destinationAmountText: destinationAmountText,
                                      destinationAddressText: destinationAddressText,
                                      exchangeRate: exchangeRate)
    }

    // MARK: - Public

    func updateOrigin(currency: Currency) {
        guard let originAmountText = originAmountTextField.text else { return }
        viewModel.updateOrigin(currency: currency,
                               originAmountText: originAmountText)
    }

    func updateDestination(currency: Currency) {
        guard let originAmountText = originAmountTextField.text else { return }
        viewModel.updateDestination(currency: currency,
                                    originAmountText: originAmountText)
    }
}
