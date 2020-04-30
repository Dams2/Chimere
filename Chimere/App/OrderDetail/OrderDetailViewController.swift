//
//  OrderDetailViewController.swift
//  Chimere
//
//  Created by Damien Rojo on 30.04.20.
//  Copyright © 2020 Damien Rojo. All rights reserved.
//

import UIKit

final class OrderDetailViewController: UIViewController {
    
    // MARK: - Properties
    
    var viewModel: OrderDetailViewModel!
    
    // MARK: - Outlets
    
    @IBOutlet private weak var statusView: UIView! {
        didSet {
            statusView.layer.cornerRadius = 10
        }
    }
    
    @IBOutlet weak var statusLabel: UILabel!
    
    
    @IBOutlet weak var originCurrencyImageView: UIImageView!
    
    @IBOutlet weak var originAmountLabel: UILabel!
    
    @IBOutlet weak var originCurrencySymbolLabel: UILabel!
    
    @IBOutlet weak var toImageView: UIImageView!
    
    @IBOutlet weak var destinationCurrencyImageView: UIImageView!
    
    @IBOutlet weak var destinationAmountLabel: UILabel!
    
    @IBOutlet weak var destinationCurrencySymbolLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    // MARK: - Actions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Helpers
    
    func bind(to viewModel: OrderDetailViewModel) {
        
    }
}
