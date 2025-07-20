//
//  APIError.swift
//  CoffeeBrowser
//
//  Created by Evan Burdett on 7/20/25.
//
import Foundation
import SwiftUI

enum APIError: Error, LocalizedError {
    case badURL, requestFailed(Int), decodingFailed, emptyData, unknown
    var errorDescription: String? {
        switch self {
        case .badURL: return "Bad URL."
        case .requestFailed(let code): return "Request failed (\(code))."
        case .decodingFailed: return "Could not decode response."
        case .emptyData: return "No data returned."
        case .unknown: return "Unknown error."
        }
    }
}
