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
    
    // MARK: - Private Properties

    private lazy var addBackBarButtonItem: UIBarButtonItem = {
        let back =  UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .done, target: self, action: #selector(backButton))
        
        self.navigationController!.navigationBar.tintColor = #colorLiteral(red: 0.9490196078, green: 0.862745098, blue: 0.6078431373, alpha: 1)

        return back
    }()
    
    // MARK: - Outlets
    
    @IBOutlet weak private var welcomeView: UIView! {
        didSet {
            let bottomLine = CALayer()
            bottomLine.frame = CGRect(x: 0.0,
                                      y: welcomeView.frame.height - 1,
                                      width: welcomeView.frame.width,
                                      height: 1.0)
            bottomLine.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.862745098, blue: 0.6078431373, alpha: 1)
            welcomeView.layer.addSublayer(bottomLine)
        }
    }
    
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
    
    @IBAction private func didPressSignInButton(_ sender: UIButton) {
        viewModel.didPressSignIn()
    }
    
    @IBAction private func didPressSignUpButton(_ sender: UIButton) {
        
    }
}
