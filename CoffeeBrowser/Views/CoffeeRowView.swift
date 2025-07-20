//
//  CoffeeRowView.swift
//  CoffeeBrowser
//
//  Created by Evan Burdett on 7/20/25.
//
import SwiftUI

struct CoffeeRowView: View {
    let drink: CoffeeDrink
    var body: some View {
        HStack(spacing: 12) {
            AsyncRemoteImage(url: URL(string: drink.image ?? ""))
                .frame(width: 60, height: 60)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
            VStack(alignment: .leading, spacing: 4) {
                Text(drink.title).font(.headline)
                Text(drink.ingredients?.joined(separator: ", ") ?? "No ingredients")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
            }
            Spacer()
        }
        .padding(.vertical, 4)
    }
}
