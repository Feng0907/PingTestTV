//
//  Ping.swift
//  PingTest
//
//  Created by Feng on 2025/4/18.
//

import Foundation

enum NetError: Error {
    case pingFailure
    case cannotCreateURL
}

struct Ping {
    static func measure(to host: String) async throws -> Int {
        guard let url = URL(string: host) else {
            throw NetError.cannotCreateURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = "HEAD"

        let startTime = CFAbsoluteTimeGetCurrent()
        do {
            _ = try await URLSession.shared.data(for: request)
            let endTime = CFAbsoluteTimeGetCurrent()
            return Int((endTime - startTime) * 1000)
        } catch {
            throw NetError.pingFailure
        }
    }
}
