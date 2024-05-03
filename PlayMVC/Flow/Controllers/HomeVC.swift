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
        button.setLargeImage(systemName: "play.fill")
        let action = UIAction { [weak self] _ in
            self?.playButtonTapped()
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    
    private lazy var timerLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00:00"
        label.textAlignment = .center
        label.backgroundColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 40)
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        timer.timeUpdateHandler = { [weak self] time in
            self?.timerLabel.text = time
        }
        return label
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
        timerLabel.frame = CGRect(x: xPosition, y: 40, width: labelWidth, height: labelHeight)
        playButton.pulsate()
    }
    
    //MARK: Setup
    private func setupViews() {
        view.addSubview(playButton)
        view.addSubview(timerLabel)
    }
}

extension HomeVC {
    func playButtonTapped() {
        switch buttonState {
        case .play:
            buttonState = .pause
            playButton.setLargeImage(systemName: "pause.fill")
            playButton.layer.removeAllAnimations()
            timerLabel.pulsate()
            timer.startTimer()
        case .pause:
            buttonState = .play
            playButton.setLargeImage(systemName: "play.fill")
            timerLabel.layer.removeAllAnimations()
            playButton.pulsate()
            timer.stopTimer()
        }
    }
}
