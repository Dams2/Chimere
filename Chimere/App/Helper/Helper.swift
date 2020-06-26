//
//  Helper.swift
//  Chimere
//
//  Created by Damien Rojo on 06.05.20.
//  Copyright © 2020 Damien Rojo. All rights reserved.
//

import UIKit
import AVFoundation

final class Helper {
    
    lazy var setTitleViewImage: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0,
                                                  y: 0,
                                                  width: 40,
                                                  height: 40))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "Chimere")
        imageView.image = image
        return imageView
    }()

    func openTermsOfUseLink() -> String {
        let stringUrl = "https://chimere.io/terms-of-use"
        return stringUrl
    }
    
    func openHowItWorkLink() -> String {
        let stringUrl = "https://www.chimere.io/how-it-works"
        return stringUrl
    }
    
    func openMoonPay() -> String {
        let stringUrl = "https://buy-staging.moonpay.io/?apiKey=pk_test_jIDOTIygj6fx1MLkSwuINiPl2LpCxx&colorCode=%235A7302"
        return stringUrl
    }
    
    func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)

        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)

            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }

        return nil
    }
    
    func copyNotified(button: UIButton, label: UILabel, bool: Bool) {
        guard let string = label.text else { return }
        if bool == true {
           UIPasteboard.general.string = string.filter("0123456789.".contains)
        } else {
            UIPasteboard.general.string = string
        }
        
        button.setBackgroundImage(UIImage(systemName: "checkmark.seal"), for: .normal)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            button.setBackgroundImage(UIImage(systemName: "square.on.square"), for: .normal)
        }
    }
}
