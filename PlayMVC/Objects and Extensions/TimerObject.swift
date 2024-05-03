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
    
    var timeUpdateHandler: ((String) -> Void)?
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            self.counter += 1
            let seconds = self.counter % 60
            let minutes = (self.counter / 60) % 60
            let hours = self.counter / 3600
            let timeString = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
            self.timeUpdateHandler?(timeString)
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
        counter = 0
        self.timeUpdateHandler?("00:00:00")
    }
}


