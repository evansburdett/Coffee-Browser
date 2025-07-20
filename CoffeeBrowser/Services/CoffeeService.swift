import Foundation

protocol CoffeeServicing {
    func fetchDrinks(kind: CoffeeKind) async throws -> [CoffeeDrink]
}

struct CoffeeService: CoffeeServicing {
    private let client = APIClient()
    
    func fetchDrinks(kind: CoffeeKind) async throws -> [CoffeeDrink] {
        // 1. Fetch the raw Brewery array
        let breweries: [Brewery] = try await client.get(kind.endpoint)
        
        // 2. Map each Brewery into your CoffeeDrink model inline
        return breweries.map { b in
            CoffeeDrink(
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
                image: "https://picsum.photos/seed/\(b.id.hashValue)/200/200"
            )
        }
    }
}
