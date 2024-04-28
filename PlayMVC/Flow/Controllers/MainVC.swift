//
//  ViewController.swift
//  PlayMVC
//
//  Created by Quasar on 26.04.2024.
//

import UIKit



class MainVC: UIViewController {
    private var timer = TimerObject()
    private var buttonState: ButtonState = .play

   private lazy var playButton: UIButton = {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 10, width: 140, height: 140)
        button.tintColor = .white
        button.backgroundColor = .darkGray
        button.layer.cornerRadius = button.frame.size.width / 2
        button.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
        button.setLargeImage(systemName: "play.fill")
        return button
    }()


    private lazy var mapButton: UIButton = {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 70, height: 70)
        button.setTitle("Map", for: .normal)
        button.backgroundColor = .red
        button.layer.cornerRadius = button.frame.size.width / 2
        button.addTarget(self, action: #selector(mapEnter), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var rateMenuButton: UIButton = {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 70, height: 70)
        button.setTitle("Share", for: .normal)
        button.backgroundColor = .green
        button.layer.cornerRadius = button.frame.size.width / 2
        button.addTarget(self, action: #selector(RateEnter), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()


    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        playButton.center = view.center
        let labelWidth: CGFloat = 200
        let labelHeight: CGFloat = 50
        let xPosition = (self.view.frame.width - labelWidth) / 2
        timer.timerLabel.frame = CGRect(x: xPosition, y: 40, width: labelWidth, height: labelHeight)
        pulsate(UIElement: playButton)
    }

//MARK: Setup
    private func setupViews() {
        view.addSubview(playButton)
        view.addSubview(timer.timerLabel)
        view.addSubview(mapButton)
        view.addSubview(rateMenuButton)

        NSLayoutConstraint.activate([
              mapButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
              mapButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
              mapButton.widthAnchor.constraint(equalToConstant: 70),
              mapButton.heightAnchor.constraint(equalToConstant: 70),
              rateMenuButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
                    rateMenuButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
                    rateMenuButton.widthAnchor.constraint(equalToConstant: 70),
                    rateMenuButton.heightAnchor.constraint(equalToConstant: 70)
          ])
    }
}

//MARK: @objc extension
@objc extension MainVC {

    func mapEnter() {
        let secondViewController = SecondVC()
        secondViewController.modalPresentationStyle = .fullScreen
        self.present(secondViewController, animated: true)

    }

    func RateEnter() {
        let thirdViewController = ThirdVC()
        thirdViewController.modalPresentationStyle = .fullScreen
        self.present(thirdViewController, animated: true)
    }

    func playButtonTapped() {
        switch buttonState {
        case .play:
            buttonState = .pause
            playButton.setLargeImage(systemName: "pause.fill")
            playButton.layer.removeAllAnimations()
            pulsate(UIElement: timer.timerLabel)
            timer.startTimer()
        case .pause:
            buttonState = .play
            playButton.setLargeImage(systemName: "play.fill")
            timer.timerLabel.layer.removeAllAnimations()
            pulsate(UIElement: playButton)
            timer.stopTimer()
        }
    }
}
