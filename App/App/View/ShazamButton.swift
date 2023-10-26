//
//  ShazamButton.swift
//  App
//
//  Created by talate on 8.10.2023.
//

import UIKit

protocol ShazamButtonProtocol: AnyObject {
    func shazamButtonDidClick(isListening: Bool)
}

class ShazamButton: UIButton {

    private var isInitial: Bool = true
    
    weak var delegate: ShazamButtonProtocol?

    func initialAnimation() {
        let basicPulse: PulseAnimation = BasicPulse(duration: 1.0, toValue: 1.2)
        layer.add(basicPulse.createAnimation(), forKey: "pulse")
    }
    
    func postTapAnimation() {
        let springPulse: PulseAnimation = SpringPulse(duration: 1.0, toValue: 1.2, damping: 2)
        layer.add(springPulse.createAnimation(), forKey: "pulsate")
        
        let circularFactory: ShapeFactory = CircularShape(color: UIColor.white.withAlphaComponent(0.3), lineWidth: 10)
        let pulseLayer = circularFactory.createShape(bounds: self.bounds)
        
        self.layer.insertSublayer(pulseLayer, at: 0)
        pulseLayer.add(springPulse.createAnimation(), forKey: "pulse_shape_layer")
    }
    
    func startListening() {
        if isInitial {
            layer.removeAnimation(forKey: "pulse")
            postTapAnimation()
            isInitial = false
            delegate?.shazamButtonDidClick(isListening: true)
        }
    }
    
    func cancelListening() {
        if (!isInitial) {
            layer.removeAnimation(forKey: "pulsate")
            layer.sublayers?[0].removeFromSuperlayer()
            initialAnimation()
            isInitial = true
            delegate?.shazamButtonDidClick(isListening: false)
        }
    }
    
    private func observeAppLifecycle() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(appWillEnterForeground),
                                               name: UIApplication.willEnterForegroundNotification,
                                               object: nil)
    }
    
    @objc private func appWillEnterForeground() {
        if isInitial {
            initialAnimation()
        } else {
            postTapAnimation()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        initialAnimation()
        observeAppLifecycle()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialAnimation()
        observeAppLifecycle()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
