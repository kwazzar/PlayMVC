//
//  ThirdVC.swift
//  PlayMVC
//
//  Created by Quasar on 27.04.2024.
//

import UIKit
import StoreKit

final class ShareVC: UIViewController {
    
    let tableView = UITableView()
    var buttons: [ButtonsOnShareVC] = [.rateButton, .shareButton, .contactButton]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = .darkGray
        setupTableView()
        tableView.register(ButtonCell.self, forCellReuseIdentifier: "ButtonCell")
        tableView.delegate = self
        tableView.dataSource = self
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
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected row at index path: \(indexPath)")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return buttons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ButtonCell", for: indexPath) as? ButtonCell
        
        let buttonType = buttons[indexPath.row]
        let action = buttonType.buttonAction(in: self)
        
        switch buttonType {
        case .rateButton:
            cell?.rateButton.addAction(action, for: .touchUpInside)
        case .shareButton:
            cell?.shareButton.addAction(action, for: .touchUpInside)
        case .contactButton:
            cell?.contactButton.addAction(action, for: .touchUpInside)
        }
        return cell ?? ButtonCell()
    }
}

