//
//  HomeViewController.swift
//  antex
//
//  Created by Damien Rojo on 14.04.20.
//  Copyright © 2020 Damien Rojo. All rights reserved.
//

import UIKit
import AVFoundation

final class ExchangeViewController: UIViewController {
    
    // MARK: - Properties

    var viewModel: ExchangeViewModel!
        
    var captureSession: AVCaptureSession!
    
    var previewLayer: AVCaptureVideoPreviewLayer!

    
    // MARK: - Private Properties
    
    private let helper = Helper()

    // MARK: - Outlets

    @IBOutlet weak var scanView: UIView! {
        didSet {
            scanView.layer.borderWidth = 1
            scanView.layer.cornerRadius = 10
            scanView.layer.borderColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
            scanView.isHidden = true
        }
    }

    @IBOutlet weak var scanLabel: UILabel!
    
    @IBOutlet weak private var descriptionTextView: UITextView!

    // Deposit //

    @IBOutlet weak private var originView: UIView! {
        didSet {
            originView.layer.borderWidth = 1
            originView.layer.borderColor = #colorLiteral(red: 0.9490196078, green: 0.862745098, blue: 0.6078431373, alpha: 1)
            originView.layer.cornerRadius = 10
        }
    }

    @IBOutlet weak private var originLabel: UILabel!

    @IBOutlet weak private var originAmountTextField: UITextField! {
        didSet {
            originAmountTextField.keyboardType = .decimalPad
            originAmountTextField.backgroundColor = .none
        }
    }

    @IBOutlet weak private var originCurrencyView: UIView! {
        didSet {
            originCurrencyView.layer.cornerRadius = 10
            originCurrencyView.layer.borderWidth = 1
            originCurrencyView.layer.borderColor = #colorLiteral(red: 0.3529411765, green: 0.4509803922, blue: 0.007843137255, alpha: 1)
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
            switchButton.tintColor = .white
        }
    }

    // Destination //

    @IBOutlet weak private var destinationView: UIView! {
        didSet {
            destinationView.layer.borderWidth = 1
            destinationView.layer.borderColor = #colorLiteral(red: 0.9490196078, green: 0.862745098, blue: 0.6078431373, alpha: 1)
            destinationView.layer.cornerRadius = 10
        }
    }

    @IBOutlet weak private var destinationLabel: UILabel!

    @IBOutlet weak private var destinationAmountTextField: UITextField! {
        didSet {
            destinationAmountTextField.keyboardType = .decimalPad
            destinationAmountTextField.backgroundColor = .none
            destinationAmountTextField.isUserInteractionEnabled = false
        }
    }

    @IBOutlet weak private var destinationCurrencyView: UIView! {
        didSet {
            destinationCurrencyView.layer.cornerRadius = 10
            destinationCurrencyView.layer.borderWidth = 1
            destinationCurrencyView.layer.borderColor = #colorLiteral(red: 0.3529411765, green: 0.4509803922, blue: 0.007843137255, alpha: 1)
        }
    }

    @IBOutlet weak private var destinationCurrencyNameLabel: UILabel!

    @IBOutlet weak private var destinationCurrencySymbolLabel: UILabel!

    @IBOutlet weak private var changeDestinationCurrencyButton: UIButton!

    @IBOutlet weak var destinationAddressTextField: UITextField!
    
    @IBOutlet weak private var scanQRCodeButton: UIButton!
    
    // Warning //
    
    @IBOutlet weak private var warningImageView: UIImageView!
    
    @IBOutlet weak private var warningLabel: UILabel!
    
    @IBOutlet weak private var warningAmountButton: UIButton!
    
    @IBOutlet weak private var exchangeNowButton: UIButton! {
        didSet {
            exchangeNowButton.layer.cornerRadius = 10
            exchangeNowButton.layer.borderWidth = 1
            exchangeNowButton.layer.borderColor = #colorLiteral(red: 0.9490196078, green: 0.862745098, blue: 0.6078431373, alpha: 1)
        }
    }

    // MARK: - View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideWhenTappedAround()
        setUI()
        bind(to: viewModel)
        viewModel.viewDidLoad()
    }

    // MARK: - Helpers
    
    private func setUI() {
        self.navigationItem.titleView = helper.setTitleViewImage
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        let addHowItWorkButton = UIBarButtonItem(image: UIImage(systemName: "info.circle"),
                                                 style: .done,
                                                 target: self,
                                                 action: #selector(infoButton))
        addHowItWorkButton.tintColor = #colorLiteral(red: 0.9490196078, green: 0.862745098, blue: 0.6078431373, alpha: 1)
        navigationItem.setRightBarButton(addHowItWorkButton,
                                                animated: true)
        
        self.tabBarController?.tabBar.barTintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.tabBarController?.tabBar.tintColor = #colorLiteral(red: 0.3529411765, green: 0.4509803922, blue: 0.007843137255, alpha: 1)
    }

    private func bind(to viewModel: ExchangeViewModel) {
        viewModel.loadingState = { [weak self] state in
            DispatchQueue.main.async {
                self?.switchButton.layer.backgroundColor = state ? #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1) : #colorLiteral(red: 0.3529411765, green: 0.4509803922, blue: 0.007843137255, alpha: 1)
                switch state {
                case true:
                    self?.switchButton.isEnabled = false
                case false:
                    self?.switchButton.isEnabled = true
                }
            }
        }

        viewModel.scanText = { [weak self] text in
            DispatchQueue.main.async {
                self?.scanLabel.text = text
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
        
        viewModel.scanQRCodeImageText = { [weak self] text in
            DispatchQueue.main.async {
                self?.scanQRCodeButton.setImage(UIImage(systemName: text), for: .normal)
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
    
    @objc private func infoButton() {
        viewModel.didPreessHowItWork()
    }

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
    
    @IBAction private func didPressDestinationAddressTextField(_ sender: UITextField) {
        var counter = 0
        counter += 1
        if counter == 1 {
            if let myString = UIPasteboard.general.string {
                sender.text = myString
            }
        }
    }
    
    @IBAction private func didPressScanQRCodeButton(_ sender: UIButton) {
        openCamera()
    }
    
    @IBAction private func didPressWarningAmountButton(_ sender: UIButton) {
        guard let warningAmountText = sender.titleLabel?.text,
            let originAmountText = originAmountTextField.text
            else { return }

        viewModel.didPressWarningAmount(warningAmountText: warningAmountText, originAmount: originAmountText)
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

