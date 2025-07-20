//
//  Brewery.swift
//  CoffeeBrowser
//
//  Created by Evan Burdett on 7/20/25.
//


import Foundation

struct Brewery: Codable, Identifiable {
    let id: String
    let name: String
    let brewery_type: String?
    let city: String?
    let state: String?
    let country: String?
    let website_url: String?
}
