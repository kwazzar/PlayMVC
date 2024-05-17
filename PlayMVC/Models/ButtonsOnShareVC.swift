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
    
    var buttonTitle: String {
        switch self {
        case .rateButton: return NSLocalizedString("Rate button", comment: "")
        case .shareButton: return NSLocalizedString("Share button", comment: "")
        case .contactButton: return NSLocalizedString("Contact button", comment: "")
        }
    }
    
    var buttonColor: UIColor {
        switch self {
        case .rateButton: return .gray
        case .shareButton: return .black
        case .contactButton: return .red
        }
    }
    
    func buttonAction(in viewController: UIViewController) -> UIAction {
        switch self {
        case .rateButton:
            return UIAction { _ in
                guard let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene else { return }
                DispatchQueue.main.async {
                    SKStoreReviewController.requestReview(in: scene)
                }
            }
        case .shareButton:
            return UIAction { _ in
                DispatchQueue.global().async {
                    let text = "Check out this amazing app!"
                    guard let url = URL(string: KeysUrl.appStoreURL.key) else { return }
                    
                    DispatchQueue.main.async {
                        let activityViewController = UIActivityViewController(activityItems: [text, url], applicationActivities: nil)
                        viewController.present(activityViewController, animated: true, completion: nil)
                    }
                }
            }
        case .contactButton:
            return UIAction { _ in
                DispatchQueue.global().async {
                    guard let url = URL(string: KeysUrl.contactUsURL.key) else { return }
                    DispatchQueue.main.async {
                        UIApplication.shared.open(url, options: [:])
                    }
                }
            }
        }
    }
}

