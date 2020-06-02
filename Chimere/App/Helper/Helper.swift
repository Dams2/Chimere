//
//  Helper.swift
//  Chimere
//
//  Created by Damien Rojo on 06.05.20.
//  Copyright © 2020 Damien Rojo. All rights reserved.
//

import UIKit

final class Helper {
    
    func openTermsOfUseLink() -> String {
        let stringUrl = "https://chimere.io/terms-of-use"
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
    
    func copyNotified(button: UIButton, label: UILabel) {
        guard let string = label.text else { return }
        UIPasteboard.general.string = string.filter("0123456789.".contains)
        button.setBackgroundImage(UIImage(systemName: "checkmark.seal"), for: .normal)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            button.setBackgroundImage(UIImage(systemName: "square.on.square"), for: .normal)
        }
    }
}
