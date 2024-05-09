//
//  Extensions + UIView.swift
//  PlayMVC
//
//  Created by Quasar on 26.04.2024.
//

import UIKit

extension UIView {
    func rotate360Degrees(duration: CFTimeInterval = 1.0, completionDelegate: AnyObject? = nil) {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat(Double.pi * 2.0)
        rotateAnimation.duration = duration
        rotateAnimation.repeatCount = .greatestFiniteMagnitude
        
        if let delegate: AnyObject = completionDelegate {
            rotateAnimation.delegate = (delegate as! any CAAnimationDelegate)
        }
        self.layer.add(rotateAnimation, forKey: nil)
    }
}

extension UIView {
    func pulsate() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.6
        pulse.fromValue = 0.95
        pulse.toValue = 1.05
        pulse.autoreverses = true
        pulse.repeatCount = .infinity
        pulse.initialVelocity = 0.5
        pulse.damping = 1.0
        self.layer.add(pulse, forKey: nil)
    }
}
