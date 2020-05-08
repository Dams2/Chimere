//
//  Helper.swift
//  Chimere
//
//  Created by Damien Rojo on 06.05.20.
//  Copyright © 2020 Damien Rojo. All rights reserved.
//

import UIKit

final class Helper {
    
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
        UIPasteboard.general.string = label.text
        button.setBackgroundImage(UIImage(systemName: "checkmark.seal"), for: .normal)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            button.setBackgroundImage(UIImage(systemName: "square.on.square"), for: .normal)
        }
    }
    
    func colorCode(state: String, text: UILabel) {
        if state == "Loaded" {
            text.textColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        } else if state == "Exchanging" {
            text.textColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
        } else if state == "Completed" {
            text.textColor = #colorLiteral(red: 0, green: 1, blue: 0.1254132986, alpha: 1)
        } else if state == "Not yet paid" {
            text.textColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        } else if state == "Expired" {
            text.textColor = #colorLiteral(red: 1, green: 0.5252228379, blue: 0.08720958978, alpha: 1)
        } else if state == "Failed" {
            text.textColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
        }
    }
}
