//
//  TermsOfUseViewController.swift
//  Chimere
//
//  Created by Damien Rojo on 02.06.20.
//  Copyright © 2020 Damien Rojo. All rights reserved.
//

import UIKit
import WebKit

final class TermsOfUseViewController: UIViewController {

    // MARK: - Private Properties
    
    let helper = Helper()
    
    // MARK: - Outlets
    
    @IBOutlet weak private var webView: WKWebView!
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.scrollView.bounces = false
        DispatchQueue.main.async {
            self.webView.load(self.helper.openTermsOfUseLink())
        }
    }
}

extension WKWebView {
    func load(_ urlString: String) {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            load(request)
        }
    }
}
