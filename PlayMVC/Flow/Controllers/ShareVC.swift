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
    private var buttons: [ButtonsOnShareVC] = ButtonsOnShareVC.allCases
    private let collectionViewHeight: CGFloat = 100
    
    init() {
        let layout = UICollectionViewFlowLayout()
        defer {
            layout.itemSize = CGSize(width: collectionView.frame.width, height: collectionViewHeight)
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
    
    private func setupCollectionView() {
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
        return CGSize(width: width, height: collectionViewHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return buttons.count
    }
    
    //MARK: Button action
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ButtonCell", for: indexPath) as? ButtonCell else {
            return ButtonCell()
        }
        
        let buttonType = buttons[indexPath.row]
        cell.buttonType = buttonType
        
        let action = buttonType.buttonAction(in: self)
        let animationButton: UIAction = UIAction { [weak cell] _ in
            cell?.button.buttonAnimationTapped()
        }
        
        cell.button.addAction(animationButton, for: .touchUpInside)
        cell.button.addAction(action, for: .touchUpInside)
        
        return cell
    }
}
