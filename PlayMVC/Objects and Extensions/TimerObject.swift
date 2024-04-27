//
//  TimerObject.swift
//  PlayMVC
//
//  Created by Quasar on 26.04.2024.
//

import Foundation
import UIKit



final class TimerObject {
    private var timer: Timer? = nil
    private var counter = 0

    lazy var timerLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00:00"
        label.textAlignment = .center
        label.backgroundColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 40)
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        return label
    }()

    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            self.counter += 1
            let seconds = self.counter % 60
            let minutes = (self.counter / 60) % 60
            let hours = self.counter / 3600
            self.timerLabel.text = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        }
    }

    func stopTimer() {
        timer?.invalidate()
        timer = nil
        counter = 0
        timerLabel.text = "00:00:00"
    }
}


