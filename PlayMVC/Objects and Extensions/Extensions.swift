//
//  Extensions.swift
//  PlayMVC
//
//  Created by Quasar on 26.04.2024.
//

import Foundation
import UIKit

extension UIButton {
    func setLargeImage(systemName: String) {
        if let image = UIImage(systemName: systemName) {
             let largeConfig = UIImage.SymbolConfiguration(pointSize: 70, weight: .bold, scale: .large)
             let largeImage = image.applyingSymbolConfiguration(largeConfig)
             self.setImage(largeImage, for: .normal)
         }
    }
}

func pulsate<T: UIView>(UIElement: T) {
      let pulse = CASpringAnimation(keyPath: "transform.scale")
      pulse.duration = 0.6
      pulse.fromValue = 0.95
     pulse.toValue = 1.05
      pulse.autoreverses = true
      pulse.repeatCount = .infinity
      pulse.initialVelocity = 0.5
      pulse.damping = 1.0

      UIElement.layer.add(pulse, forKey: nil)
  }
