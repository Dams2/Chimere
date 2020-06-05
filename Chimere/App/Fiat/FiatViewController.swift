//
//  FiatViewController.swift
//  Chimere
//
//  Created by Damien Rojo on 05.06.20.
//  Copyright © 2020 Damien Rojo. All rights reserved.
//

import UIKit
import WebKit

final class FiatViewController: UIViewController, WKNavigationDelegate {
    
    // MARK: - Private Properties
    
    let helper = Helper()
    
    // MARK: - Outlets
    
    @IBOutlet weak private var webView: WKWebView!

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - View life cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        setUI()
        DispatchQueue.main.async {
            self.webView.load(self.helper.openMoonPay())
            self.webView.addSubview(self.activityIndicator)
            self.activityIndicator.startAnimating()

            self.webView.navigationDelegate = self
//            self.activityIndicator.hidesWhenStopped = true
        }
    }
    
    // MARK: - Helpers

    private func setUI() {
        self.navigationItem.titleView = helper.setTitleViewImage
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        webView.scrollView.isScrollEnabled = false
        webView.scrollView.bounces = false
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        activityIndicator.stopAnimating()
    }
}
