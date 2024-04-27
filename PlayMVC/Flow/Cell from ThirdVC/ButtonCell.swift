//
//  ButtonCell.swift
//  PlayMVC
//
//  Created by Quasar on 27.04.2024.
//

import UIKit

protocol ButtonCellDelegate: AnyObject {
    func didTapRateButton()
    func didTapShareButton()
    func didTapContactButton()
}

class ButtonCell: UITableViewCell {
    weak var delegate: ButtonCellDelegate?

    let rateButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .green
        button.setTitle("Rate App", for: .normal)
        button.addTarget(self, action: #selector(rateButtonTapped), for: .touchUpInside)
        return button
    }()

    let shareButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.setTitle("Share App", for: .normal)
        button.addTarget(self, action: #selector(shareButtonTapped), for: .touchUpInside)
        return button
    }()

    let contactButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .red
        button.setTitle("Contact Us", for: .normal)
        button.addTarget(self, action: #selector(contactButtonTapped), for: .touchUpInside)
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
        [rateButton, shareButton, contactButton].forEach {
            self.contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        NSLayoutConstraint.activate([
            rateButton.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            rateButton.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            rateButton.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            rateButton.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 1/3),

            shareButton.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            shareButton.leadingAnchor.constraint(equalTo: rateButton.trailingAnchor),
            shareButton.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            shareButton.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 1/3),

            contactButton.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            contactButton.leadingAnchor.constraint(equalTo: shareButton.trailingAnchor),
            contactButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            contactButton.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ])
    }

    @objc func rateButtonTapped() {
        delegate?.didTapRateButton()
    }

    @objc func shareButtonTapped() {
        delegate?.didTapShareButton()
    }

    @objc func contactButtonTapped() {
        delegate?.didTapContactButton()
    }
}
