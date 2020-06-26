//
//  ViewController.swift
//  antex
//
//  Created by Damien Rojo on 14.04.20.
//  Copyright © 2020 Damien Rojo. All rights reserved.
//

import UIKit

extension UIViewController {
    public static var storyboardIdentifier: String {
        return String(describing: self)
    }

    public static var nib: UINib {
        return UINib.init(nibName: storyboardIdentifier, bundle: Bundle(for: self))
    }
}

extension ExchangeViewController {
    func hideWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ExchangeViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
        scanView.isHidden = true
    }
}
