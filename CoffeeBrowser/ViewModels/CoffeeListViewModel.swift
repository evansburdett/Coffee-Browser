//
//  CoffeeListViewModel.swift
//  CoffeeBrowser
//
//  Created by Evan Burdett on 7/20/25.
//
import SwiftUI



@MainActor
final class CoffeeListViewModel: ObservableObject {
    @Published private(set) var drinks: [CoffeeDrink] = []
    @Published var selectedKind: CoffeeKind = .hot {
        didSet { Task { await load() } }
    }
    @Published var searchText: String = ""
    @Published private(set) var isLoading = false
    @Published private(set) var error: String?
    private var currentTask: Task<Void, Never>?

    
    private let service: CoffeeServicing
    
    init(service: CoffeeServicing = CoffeeService()) { self.service = service }
    
    func loadIfNeeded() {
        guard drinks.isEmpty else { return }
        Task { await load() }
    }
    
    func load() async {
        currentTask?.cancel()
        let targetKind = selectedKind
        isLoading = true
        error = nil
        
        currentTask = Task { [weak self] in
            guard let self else { return }
            
            // Try live fetch with brief retry
            do {
                let live = try await self.fetchWithRetry(kind: targetKind, maxAttempts: 2)
                guard targetKind == self.selectedKind else { return }
                if live.isEmpty {
                    let local = LocalCoffeeLoader.load(kind: targetKind)
                    if local.isEmpty {
                        throw APIError.emptyData
                    } else {
                        self.drinks = local.sorted { $0.title < $1.title }
                        self.error = "Using snapshot (live returned empty)."
                    }
                } else {
                    self.drinks = live.sorted { $0.title < $1.title }
                }
            } catch {
                guard targetKind == self.selectedKind else { return }
                let local = LocalCoffeeLoader.load(kind: targetKind)
                if !local.isEmpty {
                    self.drinks = local.sorted { $0.title < $1.title }
                    self.error = "Live fetch failed; showing cached snapshot."
                } else {
                    self.error = "Failed to load \(targetKind.label.lowercased()) drinks."
                }
            }
            self.isLoading = false
        }
    }

    private func fetchWithRetry(kind: CoffeeKind, maxAttempts: Int) async throws -> [CoffeeDrink] {
        var attempt = 0
        var lastError: Error?
        while attempt < maxAttempts {
            attempt += 1
            do {
                return try await service.fetchDrinks(kind: kind)
            } catch {
                lastError = error
                if Task.isCancelled { throw error }
                try? await Task.sleep(nanoseconds: UInt64(300_000_000 * attempt)) // 0.3s, 0.6s
            }
        }
        throw lastError ?? APIError.unknown
    }


    
    var filtered: [CoffeeDrink] {
        let q = searchText.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        guard !q.isEmpty else { return drinks }
        return drinks.filter {
            $0.title.lowercased().contains(q) ||
            $0.description.lowercased().contains(q) ||
            ($0.ingredients?.joined(separator: " ").lowercased().contains(q) ?? false)
        }
    }
}
