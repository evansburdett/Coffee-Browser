//
//  CoffeeDetailViewModel.swift
//  CoffeeBrowser
//
//  Created by Evan Burdett on 7/20/25.
//
import SwiftUI

@MainActor
final class CoffeeDetailViewModel: ObservableObject {
    let drink: CoffeeDrink
    init(drink: CoffeeDrink) { self.drink = drink }
}
