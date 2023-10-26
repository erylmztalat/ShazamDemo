//
//  UIView+Extension.swift
//  App
//
//  Created by talate on 24.09.2023.
//

import UIKit

extension UIView {
    func setGradientBackground(from startColor: UIColor, to endColor: UIColor) {
        let gradient = CAGradientLayer.gradient(from: startColor, to: endColor)
        gradient.frame = bounds
        layer.insertSublayer(gradient, at: 0)
    }
    
    func addShadow(offset: CGSize = CGSize(width: 0, height: 1),
                   color: UIColor = .black,
                   radius: CGFloat = 4.0,
                   opacity: Float = 0.1) {
        
        layer.shadowOffset = offset
        layer.shadowColor = color.cgColor
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        layer.masksToBounds = false
    }
}
