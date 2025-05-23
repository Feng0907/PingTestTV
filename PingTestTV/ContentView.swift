//
//  ContentView.swift
//  PingTestTV
//
//  Created by Feng on 2025/4/18.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = PingViewModel()

    var body: some View {
        VStack(spacing: 20) {
            Text("目前 Ping 值：\(viewModel.pingResult)")
                .font(.title)
            
            Text("測試次數： \(viewModel.testCount)")
                .foregroundColor(.red)
                .font(.headline)
            
            if viewModel.isDisconnected {
                Text("⚠️ 網路已中斷")
                    .foregroundColor(.red)
                    .font(.headline)
            }
        }
        .padding()
        .onAppear {
            viewModel.startPinging()
        }
        .onDisappear {
            viewModel.stopPinging()
        }
    }
}
