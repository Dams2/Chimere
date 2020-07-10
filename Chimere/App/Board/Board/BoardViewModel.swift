//
//  BoardViewModel.swift
//  Chimere
//
//  Created by Damien Rojo on 10.07.20.
//  Copyright © 2020 Damien Rojo. All rights reserved.
//

import Foundation

final class BoardViewModel {
    
    // MARK: - Private Properties
    
    private let delegate: BoardViewControllerDelegate?
    
    // MARK: - Init

    init(delegate: BoardViewControllerDelegate?) {
        self.delegate = delegate
    }
    
    // MARK: - Outputs
    
    var welcomeText: ((String) -> Void)?
    
    var signInText: ((String) -> Void)?
    
    var signUpText: (( String) -> Void)?
    
    // MARK: - Inputs
    
    func viewDidLoad() {
        
    }
    
    func didPressSignIn() {
        delegate?.didShowSignIn()
    }
}
