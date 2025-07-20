//
//  AsyncRemoteImage.swift
//  CoffeeBrowser
//
//  Created by Evan Burdett on 7/20/25.
//
import SwiftUI

struct AsyncRemoteImage: View {
    let url: URL?
    @State private var phase: Phase = .empty
    
    enum Phase { case empty, success(Image), failure }
    
    var body: some View {
        ZStack {
            switch phase {
            case .empty:
                Rectangle()
                    .fill(Color.gray.opacity(0.15))
                    .overlay { ProgressView() }
            case .success(let img):
                img
                    .resizable()
                    .aspectRatio(1, contentMode: .fill) // stable ratio
            case .failure:
                Rectangle()
                    .fill(Color.gray.opacity(0.1))
                    .overlay {
                        Image(systemName: "exclamationmark.triangle")
                            .foregroundColor(.secondary)
                    }
            }
        }
        .clipped()
        .task { await fetch() }  // safer than onAppear for multiple renders
    }
    
    private func fetch() async {
        guard case .empty = phase, let url else { return }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let ui = UIImage(data: data) {
                await MainActor.run { phase = .success(Image(uiImage: ui)) }
            } else {
                await MainActor.run { phase = .failure }
            }
        } catch {
            await MainActor.run { phase = .failure }
        }
    }
}
