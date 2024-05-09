//
//  ThirdVC.swift
//  PlayMVC
//
//  Created by Quasar on 27.04.2024.
//

import UIKit
import StoreKit

final class ShareVC: UIViewController {

   private let collectionView: UICollectionView
   private var buttons: [ButtonsOnShareVC] = [.rateButton, .shareButton, .contactButton]

    init() {
        let layout = UICollectionViewFlowLayout()
        defer {
            layout.itemSize = CGSize(width: collectionView.frame.width, height: 100)
        }

        layout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.backgroundColor = .darkGray
        setupCollectionView()
        collectionView.register(ButtonCell.self, forCellWithReuseIdentifier: "ButtonCell")
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    func setupCollectionView() {
        view.addSubview(collectionView)

        collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
//MARK: CollectionViewDelegate, ViewDataSource 
extension ShareVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 10
        let width = collectionView.frame.width - 2 * padding
        return CGSize(width: width, height: 100)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected item at index path: \(indexPath)")
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return buttons.count
    }


    //MARK: Button action
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ButtonCell", for: indexPath) as? ButtonCell

        let buttonType = buttons[indexPath.row]
        cell?.buttonType = buttonType
        let action = buttonType.buttonAction(in: self)

        cell?.button.addAction(action, for: .touchUpInside)
        return cell ?? ButtonCell()
    }
}

extension ShareVC {
}
