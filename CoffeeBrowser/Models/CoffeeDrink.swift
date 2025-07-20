import Foundation

struct CoffeeDrink: Codable, Identifiable {
    let id: Int
    let title: String
    let description: String
    let ingredients: [String]?
    let image: String?
}
