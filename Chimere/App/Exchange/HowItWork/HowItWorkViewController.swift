//
//  HowItWorkViewController.swift
//  Chimere
//
//  Created by Damien Rojo on 10.06.20.
//  Copyright © 2020 Damien Rojo. All rights reserved.
//

import UIKit
import WebKit

final class HowItWorkViewController: UIViewController {
    
    // MARK: - Private Properties
    
    let helper = Helper()
    
    // MARK: - Outlets
    
    @IBOutlet weak private var webView: WKWebView!
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.scrollView.bounces = false
        DispatchQueue.main.async {
            self.webView.load(self.helper.openHowItWorkLink())
        }
    }
}
