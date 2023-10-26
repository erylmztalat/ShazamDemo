//
//  ShapeFactory.swift
//  App
//
//  Created by talate on 12.10.2023.
//

import UIKit

protocol ShapeFactory {
    func createShape(bounds: CGRect) -> CAShapeLayer
}

struct CircularShape: ShapeFactory {
    var color: UIColor
    var lineWidth: CGFloat
    
    func createShape(bounds: CGRect) -> CAShapeLayer {
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = lineWidth
        shapeLayer.fillColor = color.cgColor
        shapeLayer.lineCap = .round
        
        let circularPath = UIBezierPath(arcCenter: CGPoint(x: bounds.midX, y: bounds.midY), radius: bounds.size.width/2, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        shapeLayer.frame = bounds
        shapeLayer.path = circularPath.cgPath
        shapeLayer.position = CGPoint(x: bounds.midX, y: bounds.midY)
        
        return shapeLayer
    }
}
