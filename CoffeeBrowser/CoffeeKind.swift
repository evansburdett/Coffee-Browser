//
//  CoffeeKind.swift
//  CoffeeBrowser
//
//  Created by Evan Burdett on 7/20/25.
//
import Foundation


enum CoffeeKind: String, CaseIterable, Identifiable {
    case hot, iced
    var id: String { rawValue }
    var label: String { rawValue.capitalized }
    
    // Use brewery_type filters to make the segment appear to change data.
    var endpoint: URL {
        switch self {
        case .hot:
            // micro + brewpub
            return URL(string: "https://api.openbrewerydb.org/v1/breweries?per_page=50&by_type=micro")!
        case .iced:
            // regional + large sample
            return URL(string: "https://api.openbrewerydb.org/v1/breweries?per_page=50&by_type=regional")!
        }
    }
}
