//
//  ButtonCell.swift
//  PlayMVC
//
//  Created by Quasar on 27.04.2024.
//

import UIKit

final class ButtonCell: UITableViewCell {
    
    lazy var rateButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .darkGray
        button.setTitle("Rate App", for: .normal)
        return button
    }()
    
    lazy var shareButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.setTitle("Share App", for: .normal)
        return button
    }()
    
    lazy var contactButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .red
        button.setTitle("Contact Us", for: .normal)
        return button
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupButtons()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: SETUP
    func setupButtons() {
        let stackView = UIStackView(arrangedSubviews: [rateButton, shareButton, contactButton])
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ])
    }
}
