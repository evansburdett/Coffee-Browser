//
//  LocalCoffeeLoader.swift
//  CoffeeBrowser
//
//  Created by Evan Burdett on 7/20/25.
//


import Foundation

enum LocalCoffeeLoader {
    static func load(kind: CoffeeKind) -> [CoffeeDrink] {
        let name = "coffee_\(kind.rawValue)"      // coffee_hot / coffee_iced
        guard let url = Bundle.main.url(forResource: name, withExtension: "json") else {
            print("LocalCoffeeLoader: \(name).json NOT FOUND")
            return []
        }
        do {
            let data = try Data(contentsOf: url)
            let list = try JSONDecoder().decode([CoffeeDrink].self, from: data)
            return list
        } catch {
            print("LocalCoffeeLoader decode error for \(name):", error)
            return []
        }
    }
}
