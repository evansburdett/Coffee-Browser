//
//  CoffeeListView.swift
//  CoffeeBrowser
//
//  Created by Evan Burdett on 7/20/25.
//
import SwiftUI

struct CoffeeListView: View {
    @StateObject private var vm = CoffeeListViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 8) {
                kindPicker
                searchField
                content
            }
            .padding(.horizontal)
            .navigationTitle("Coffee")
        }
        .task { vm.loadIfNeeded() }
    }
    
    private var kindPicker: some View {
        Picker("Type", selection: $vm.selectedKind) {
            ForEach(CoffeeKind.allCases) { kind in
                Text(kind.label).tag(kind)   // tag is the enum itself
            }
        }
        .pickerStyle(.segmented)
    }
    
    private var searchField: some View {
        TextField("Search…", text: $vm.searchText)
            .textFieldStyle(.roundedBorder)
    }
    
    @ViewBuilder
    private var content: some View {
        if vm.isLoading && vm.drinks.isEmpty {
            Spacer()
            ProgressView()
            Spacer()
        } else if let err = vm.error, vm.drinks.isEmpty {
            VStack(spacing: 12) {
                Text("Failed to load").font(.headline)
                Text(err).font(.caption).foregroundColor(.secondary)
                Button("Retry") { Task { await vm.load() } }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        } else {
            List {
                ForEach(vm.filtered) { drink in
                    NavigationLink {
                        CoffeeDetailView(drink: drink)
                    } label: {
                        CoffeeRowView(drink: drink)
                    }
                }
            }
            .id(vm.selectedKind)
            .listStyle(.plain)
        }
    }
}
