//
//  TimerObject.swift
//  PlayMVC
//
//  Created by Quasar on 26.04.2024.
//
import UIKit

final class TimerObject {
    private var timer: Timer? = nil
    private var counter = 0
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }()
    
    var timeUpdateHandler: ((String) -> Void)?
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            self.counter += 1
            let date = Date(timeIntervalSince1970: TimeInterval(self.counter))
            let timeString = self.dateFormatter.string(from: date)
            self.timeUpdateHandler?(timeString)
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
        resetTimer()
    }
    
    private func resetTimer() {
        counter = 0
        let date = Date(timeIntervalSince1970: TimeInterval(self.counter))
        let timeString = self.dateFormatter.string(from: date)
        self.timeUpdateHandler?(timeString)
    }
}
