//
//  ButtonsOnShareVC.swift
//  PlayMVC
//
//  Created by Quasar on 03.05.2024.
//

import UIKit
import StoreKit

enum ButtonsOnShareVC: CaseIterable {
    case rateButton
    case shareButton
    case contactButton
    
    func buttonAction(in viewController: UIViewController) -> UIAction {
        switch self {
        case .rateButton:
            return UIAction { _ in
                if #available(iOS 14.0, *) {
                    guard let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene else { return }
                    SKStoreReviewController.requestReview(in: scene)
                } else {
                    // Fallback on earlier versions
                }
            }
        case .shareButton:
            return UIAction { _ in
                let text = "Check out this amazing app!"
                guard let url = URL(string: appStoreURL) else { return }
                
                let activityViewController = UIActivityViewController(activityItems: [text, url], applicationActivities: nil)
                viewController.present(activityViewController, animated: true, completion: nil)
            }
        case .contactButton:
            return UIAction { _ in
                guard let url = URL(string: contactUsURL) else { return }
                UIApplication.shared.open(url, options: [:])
            }
        }
    }
}

