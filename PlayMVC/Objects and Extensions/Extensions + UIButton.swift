//
//  Extensions + UIButton.swift
//  PlayMVC
//
//  Created by Quasar on 09.05.2024.
//
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

extension UIButton {
    func buttonAnimationTapped() {
        UIView.animate(withDuration: 0.1, animations: {
            self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }) { _ in
            UIView.animate(withDuration: 0.1, animations: {
                self.transform = CGAffineTransform.identity
            })
        }
    }
}

extension UIButton {
    func buttonShadowAndVolume() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 6.0)
        self.layer.shadowRadius = 8
        self.layer.shadowOpacity = 0.5
    }
}
