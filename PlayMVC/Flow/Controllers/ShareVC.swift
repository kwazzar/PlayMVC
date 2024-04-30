//
//  ThirdVC.swift
//  PlayMVC
//
//  Created by Quasar on 27.04.2024.
//

import UIKit
import StoreKit

final class ShareVC: UIViewController {

   private let appStoreURL = "https://www.apple.com/app-store/"
   private let contactUsURL = "https://energise.notion.site/Swift-fac45cd4d51640928ce8e7ea38552fc3"

    let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.backgroundColor = .darkGray
        setupTableView()
    }
}

@objc extension ShareVC {
    func rateApp() {
        if #available(iOS 14.0, *) {
            guard let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene else { return }
            SKStoreReviewController.requestReview(in: scene)
        } else {
            // Fallback on earlier versions
        }
    }


    func shareApp() {
        let text = "Check out this amazing app!"
        guard let url = URL(string: appStoreURL) else { return }

        let activityViewController = UIActivityViewController(activityItems: [text, url], applicationActivities: nil)
        present(activityViewController, animated: true, completion: nil)
    }

    func contactUs() {
        guard let url = URL(string: contactUsURL) else { return }
            UIApplication.shared.open(url, options: [:])
    }
}

extension ShareVC: ButtonCellDelegate {
    func didTapRateButton() {
        rateApp()
    }

    func didTapShareButton() {
        shareApp()
    }

    func didTapContactButton() {
        contactUs()
    }
}
//MARK: Table View
extension ShareVC: UITableViewDataSource, UITableViewDelegate {
    
    func setupTableView() {
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        tableView.register(ButtonCell.self, forCellReuseIdentifier: "ButtonCell")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected row at index path: \(indexPath)")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ButtonCell", for: indexPath) as! ButtonCell
        cell.delegate = self

          return cell
      }
}
