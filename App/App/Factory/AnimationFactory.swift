//
//  AnimationFactory.swift
//  App
//
//  Created by talate on 12.10.2023.
//

import UIKit

protocol AnimationFactory {
    func createAnimation() -> CAAnimation
}

protocol AnimationConfiguration {
    var duration: CFTimeInterval { get }
    var timingFunction: CAMediaTimingFunction { get }
}

protocol PulseAnimation: AnimationFactory, AnimationConfiguration {
    var toValue: Any { get }
    var autoreverses: Bool { get }
    var repeatCount: Float { get }
}

extension PulseAnimation {
    var timingFunction: CAMediaTimingFunction {
        return CAMediaTimingFunction(name: .easeOut)
    }
    
    var autoreverses: Bool {
        return true
    }
    
    var repeatCount: Float {
        return .infinity
    }
}

struct BasicPulse: PulseAnimation {
    var duration: CFTimeInterval
    var toValue: Any
    
    func createAnimation() -> CAAnimation {
        let pulse = CABasicAnimation(keyPath: "transform.scale")
        pulse.duration = duration
        pulse.toValue = toValue
        pulse.autoreverses = autoreverses
        pulse.repeatCount = repeatCount
        pulse.timingFunction = timingFunction
        return pulse
    }
}

struct SpringPulse: PulseAnimation {
    var duration: CFTimeInterval
    var toValue: Any
    var damping: CGFloat
    
    func createAnimation() -> CAAnimation {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = duration
        pulse.toValue = toValue
        pulse.autoreverses = autoreverses
        pulse.repeatCount = repeatCount
        pulse.timingFunction = timingFunction
        pulse.damping = damping
        return pulse
    }
}
