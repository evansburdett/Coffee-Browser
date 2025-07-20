import Foundation

extension CoffeeDrink {
    static func fromBrewery(_ b: Brewery) -> CoffeeDrink {
        return CoffeeDrink(
            id: b.id.hashValue,
            title: b.name,
            description: [
                b.brewery_type?.capitalized,
                b.city,
                b.state,
                b.country
            ]
            .compactMap { $0 }
            .joined(separator: " • "),
            ingredients: b.website_url != nil ? [b.website_url!] : nil,
            image: nil
        )
    }
}
