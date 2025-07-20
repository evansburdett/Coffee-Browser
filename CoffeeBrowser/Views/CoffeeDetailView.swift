//
//  CoffeeDetailView.swift
//  CoffeeBrowser
//
//  Created by Evan Burdett on 7/20/25.
//
import SwiftUI

struct CoffeeDetailView: View {
    @StateObject var vm: CoffeeDetailViewModel
    
    init(drink: CoffeeDrink) {
        _vm = StateObject(wrappedValue: CoffeeDetailViewModel(drink: drink))
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                AsyncRemoteImage(url: URL(string: vm.drink.image ?? ""))
                    .frame(height: 260)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .padding(.horizontal)
                
                VStack(alignment: .leading, spacing: 12) {
                    Text(vm.drink.title)
                        .font(.largeTitle.bold())
                    if let ingredients = vm.drink.ingredients, !ingredients.isEmpty {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Ingredients").font(.headline)
                            Text(ingredients.joined(separator: ", "))
                        }
                    }
                    Text(vm.drink.description)
                        .font(.body)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            }
            .padding(.bottom)
        }
        .navigationTitle(vm.drink.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}
