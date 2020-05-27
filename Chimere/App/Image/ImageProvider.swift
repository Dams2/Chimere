//
//  ImageProvider.swift
//  Chimere
//
//  Created by Damien Rojo on 27.05.20.
//  Copyright © 2020 Damien Rojo. All rights reserved.
//

import UIKit

extension UIImageView {

    func setImage(url: URL, placeholder: UIImage? = nil, cancelledBy token: RequestCancellationToken?) {
        if let placeholder = placeholder {
            self.image = placeholder
        }

        ImageRepository.shared.getImage(for: url) { response in
            DispatchQueue.main.async {
                guard let data = response else { return }
                self.image = UIImage(data: data)
            }
        }
    }
}
