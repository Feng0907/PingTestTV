//
//  PingViewModel.swift
//  PingTest
//
//  Created by Feng on 2025/4/18.
//

import SwiftUI

@MainActor
class PingViewModel: ObservableObject {
    @Published var pingResult: String = "尚未測量"
    @Published var isDisconnected: Bool = false
    @Published var testCount: Int = 0

    private var timer: Timer?
    private var failureCount = 0
    private let maxFailures = 5
    private let host = "https://www.apple.com/tw/"

    func startPinging() {
        timer = Timer.scheduledTimer(withTimeInterval: 10, repeats: true) { _ in
            Task {
                await self.ping()
            }
        }
        timer?.fire()
    }

    func stopPinging() {
        timer?.invalidate()
        timer = nil
    }

    private func ping() async {
        do {
            let pingTime = try await Ping.measure(to: host)
            pingResult = "\(pingTime) ms"
            failureCount = 0
            testCount += 1
            isDisconnected = false
        } catch {
            failureCount += 1
            testCount += 0
            pingResult = "失敗 (\(failureCount))"
            if failureCount >= maxFailures {
                isDisconnected = true
            }
        }
    }
}
