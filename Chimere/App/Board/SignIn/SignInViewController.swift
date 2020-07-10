//
//  SignInViewController.swift
//  Chimere
//
//  Created by Damien Rojo on 10.07.20.
//  Copyright © 2020 Damien Rojo. All rights reserved.
//

import UIKit

final class SignInViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak private var segmentedControl: UISegmentedControl! {
        didSet {
            segmentedControl.backgroundColor = .blue
        }
    }
    
    @IBOutlet weak private var emailLabel: UILabel!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordLabel: UILabel!
    
    @IBOutlet weak var forgotPasswordButton: UIButton!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signInButton: UIButton!
    
    @IBOutlet weak var youAgreeLabel: UILabel!
    
    @IBOutlet weak var thermsAndPrivacyButton: UIButton!
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Actions
    
    @IBAction func didPressForgotPasswordButton(_ sender: UIButton) {
        
    }
    
    @IBAction func didPressSignInButton(_ sender: UIButton) {
        
    }
    
    @IBAction func didPressThermsAndPrivacyButton(_ sender: UIButton) {
        
    }
}
