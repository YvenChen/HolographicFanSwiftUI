//
//  Timer.swift
//  HolographicFanSwiftUI
//
//  Created by Yven Chen on 2023/4/6.
//

import Foundation

public class RepeatTimer {
    
    deinit { stop() }
    
    public static let shared = RepeatTimer()
    
    private var timer: Timer?
}

public extension RepeatTimer {
    func start(timeInterval: TimeInterval, action: @escaping () -> Void) {
        stop()
        timer = Timer.scheduledTimer(
            withTimeInterval: timeInterval,
            repeats: true) { _ in action() }
    }
    
    func stop() {
        timer?.invalidate()
        timer = nil
    }
}
