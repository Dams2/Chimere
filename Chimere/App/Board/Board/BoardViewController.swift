//
//  BoardViewController.swift
//  Chimere
//
//  Created by Damien Rojo on 10.07.20.
//  Copyright © 2020 Damien Rojo. All rights reserved.
//

import UIKit

final class BoardViewController: UIViewController {
    
    // MARK: - Properties
    
    var viewModel: BoardViewModel!
    
    // MARK: - Outlets
    
    @IBOutlet weak private var welcomeView: UIView!
    
    @IBOutlet weak private var welcomeLabel: UILabel!
    
    @IBOutlet weak private var signInButton: UIButton! {
       didSet {
           signInButton.layer.cornerRadius = 10
           signInButton.layer.borderWidth = 1
           signInButton.layer.borderColor = #colorLiteral(red: 0.9490196078, green: 0.862745098, blue: 0.6078431373, alpha: 1)
       }
    }
    
    @IBOutlet weak private var signUpButton: UIButton! {
        didSet {
            signUpButton.layer.cornerRadius = 10
            signUpButton.layer.borderWidth = 1
            signUpButton.layer.borderColor = #colorLiteral(red: 0.9490196078, green: 0.862745098, blue: 0.6078431373, alpha: 1)
        }
    }

    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    private func setUI() {
        navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: - Actions
    
    @IBAction private func didPressSignInButton(_ sender: UIButton) {
        
    }
    
    @IBAction private func didPressSignUpButton(_ sender: UIButton) {
        
    }
}
