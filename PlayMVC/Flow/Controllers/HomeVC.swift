//
//  ViewController.swift
//  PlayMVC
//
//  Created by Quasar on 26.04.2024.
//

import UIKit

final class HomeVC: UIViewController {
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

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black
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
    }
}

//MARK: @objc extension
@objc extension HomeVC {

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
