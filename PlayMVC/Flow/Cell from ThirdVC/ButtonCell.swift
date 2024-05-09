//
//  ButtonCell.swift
//  PlayMVC
//
//  Created by Quasar on 27.04.2024.
//

import UIKit

final class ButtonCell: UICollectionViewCell {

    lazy var button: UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont(name: "Helvetica Neue", size: 30)
        button.buttonVolume()
        let animationButton: UIAction = UIAction { [weak self] _ in
            button.buttonAnimation()
        }
        button.addAction(animationButton, for: .touchUpInside)

        return button
    }()
    
    var buttonType: ButtonsOnShareVC? {
        didSet {
            if let buttonType = buttonType {
                button.setTitle(buttonType.buttonTitle(), for: .normal)
                button.backgroundColor = buttonType.buttonColor()
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
    }
    
    func setupButton() {
        button.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: contentView.topAnchor),
            button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}

