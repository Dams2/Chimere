//
//  SignInViewController.swift
//  Chimere
//
//  Created by Damien Rojo on 10.07.20.
//  Copyright © 2020 Damien Rojo. All rights reserved.
//

import UIKit

final class SignInViewController: UIViewController {
    
    // MARK: - Properties

    var viewModel: SignInViewModel!
    
    // MARK: - Private Properties
    
    private lazy var addBackBarButtonItem: UIBarButtonItem = {
        let back =  UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .done, target: self, action: #selector(backButton))
        
        self.navigationController!.navigationBar.tintColor = #colorLiteral(red: 0.9490196078, green: 0.862745098, blue: 0.6078431373, alpha: 1)

        return back
    }()
    
    // MARK: - Outlets
    
    @IBOutlet weak private var segmentedControl: UISegmentedControl! {
        didSet {
            segmentedControl.selected = #colorLiteral(red: 0.3529411765, green: 0.4509803922, blue: 0.007843137255, alpha: 1)
        }
    }
    
    @IBOutlet weak private var emailLabel: UILabel!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordLabel: UILabel!
    
    @IBOutlet weak var forgotPasswordButton: UIButton!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signInButton: UIButton! {
        didSet {
            signInButton.layer.borderWidth = 1
            signInButton.layer.cornerRadius = 10
            signInButton.layer.borderColor = #colorLiteral(red: 0.9490196078, green: 0.862745098, blue: 0.6078431373, alpha: 1)
        }
    }

    @IBOutlet weak var youAgreeLabel: UILabel!

    @IBOutlet weak var thermsAndPrivacyButton: UIButton!

    // MARK: - View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }
    
    private func setUI() {
        navigationItem.leftBarButtonItem = addBackBarButtonItem
    }
    
    // MARK: - Helpers
    
    @objc func backButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Actions
    
    @IBAction func didPressForgotPasswordButton(_ sender: UIButton) {
        
    }
    
    @IBAction func didPressSignInButton(_ sender: UIButton) {
        
    }
    
    @IBAction func didPressThermsAndPrivacyButton(_ sender: UIButton) {
        
    }
}
