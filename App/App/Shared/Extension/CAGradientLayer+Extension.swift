//
//  CAGradientLayer+Extension.swift
//  App
//
//  Created by talate on 24.09.2023.
//

import UIKit

extension CAGradientLayer {
    static func gradient(from startColor: UIColor, to endColor: UIColor) -> CAGradientLayer {
        let gradient = CAGradientLayer()
        gradient.colors = [startColor.cgColor, endColor.cgColor]
        gradient.startPoint = CGPoint(x: 0.5, y: 0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1)
        return gradient
    }
}

