//
//  UIImageView+Extension.swift
//  App
//
//  Created by talate on 26.10.2023.
//

import UIKit

extension UIImageView {
    func setImage(from url: URL, placeholder: UIImage? = nil) {
        self.image = placeholder
        
        ImageLoader().loadImage(from: url) { [weak self] image in
            DispatchQueue.main.async {
                self?.image = image
            }
        }
    }
}
