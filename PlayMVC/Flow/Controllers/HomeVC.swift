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
        playButton.pulsate()
        frameForTimerLabel()
    }
    
    //MARK: Setup
    private func setupViews() {
        view.addSubview(playButton)
        view.addSubview(timerLabel)
    }
    
    private func playButtonTapped() {
        switch buttonState {
        case .play:
            buttonState = .pause
            handlePlayState()
        case .pause:
            buttonState = .play
            handlePauseState()
        }
    }
    
}
//MARK: Extension
extension HomeVC {
    private func handlePlayState() {
        playButton.layer.removeAllAnimations()
        playButton.setLargeImage(systemName: "pause.fill")
        timerLabel.pulsate()
        timer.startTimer()
    }
    
    private func handlePauseState() {
        timerLabel.layer.removeAllAnimations()
        playButton.setLargeImage(systemName: "play.fill")
        playButton.pulsate()
        timer.stopTimer()
    }
    
    private func frameForTimerLabel() {
        let labelWidth: CGFloat = 200
        let labelHeight: CGFloat = 50
        let yPosition: CGFloat = 40
        let xPosition = (self.view.frame.width - labelWidth) / 2
        timerLabel.frame = CGRect(x: xPosition, y: yPosition, width: labelWidth, height: labelHeight)
    }
}
