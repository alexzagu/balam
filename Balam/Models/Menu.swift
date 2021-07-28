//
//  Menu.swift
//  Balam
//
//  Created by Alejandro Zamudio Guajardo on 27/07/2021.
//

import Foundation

// MARK: - Definitions

struct MenuItem {

    let id: UUID
    let title: String
    let description: String
    let details: String
    let imageURL: URL?
    let price: Double
    let filteredBy: [UUID]

}

struct MenuCategory {

    let id: UUID
    let title: String
    let items: [MenuItem]

}

struct MenuFilter {

    let id: UUID
    let title: String

}

struct Menu {

    let id: UUID
    let categories: [MenuCategory]
    let filters: [MenuFilter]

}

// MARK: - Mocked Data

extension Menu {

    static let mockedData: Self = .init(id: .init(),
                                        categories: MenuCategory.mockedData,
                                        filters: MenuFilter.mockedData)

}

fileprivate extension MenuCategory {

    static let mockedData: [Self] = [
        .init(id: .init(), title: "Pizza", items: MenuItem.mockedPizza),
        .init(id: .init(), title: "Sushi", items: MenuItem.mockedSushi),
        .init(id: .init(), title: "Drinks", items: MenuItem.mockedDrinks)
    ]

}

fileprivate extension MenuItem {

    static let mockedPizza: [Self] = [
        .init(id: .init(),
              title: "Mexican",
              description: "Your typical crazy Mexican combo!",
              details: "190 grams, 40 cm",
              imageURL: .init(string: "www.balam.com/img/pizza/mexican.png"),
              price: 42,
              filteredBy: [.mockedSpicyFilterId]),
        .init(id: .init(),
              title: "4 Cheese",
              description: "Delicious 4 vegan cheese combination, including our signature blue cheese.",
              details: "230 grams, 40 cm",
              imageURL: .init(string: "www.balam.com/img/pizza/4_cheese.png"),
              price: 50,
              filteredBy: [.mockedVeganFilterId]),
        .init(id: .init(),
              title: "Napolitana",
              description: "Served with perky tomatoes and vivid greens.",
              details: "200 grams, 40 cm",
              imageURL: .init(string: "www.balam.com/img/pizza/napolitana.png"),
              price: 39,
              filteredBy: [.mockedSeasonalFilterId]),
        .init(id: .init(),
              title: "Maritime",
              description: "Our sea-inspired pizza, served with tofu-based fish and olives.",
              details: "215 grams, 40 cm",
              imageURL: .init(string: "www.balam.com/img/pizza/maritime.png"),
              price: 45,
              filteredBy: [])
    ]

    static let mockedSushi: [Self] = [
        .init(id: .init(),
              title: "California",
              description: "Fresh and ready to go!",
              details: "300 grams, 10 pieces",
              imageURL: .init(string: "www.balam.com/img/sushi/california.png"),
              price: 55,
              filteredBy: []),
        .init(id: .init(),
              title: "Jalapeño",
              description: "Our jalapeño-poppers based sushi, ready to melt your mind!",
              details: "320 grams, 10 pieces",
              imageURL: .init(string: "www.balam.com/img/sushi/jalapeno.png"),
              price: 60,
              filteredBy: [.mockedSpicyFilterId]),
        .init(id: .init(),
              title: "Mango",
              description: "You'll go full tropical with these mango-infused babies!",
              details: "315 grams, 10 pieces",
              imageURL: .init(string: "www.balam.com/img/sushi/mango.png"),
              price: 62,
              filteredBy: [.mockedSeasonalFilterId, .mockedVeganFilterId]),
        .init(id: .init(),
              title: "Tofunator",
              description: "Experience the full flavour of BBQ-marinated tofu.",
              details: "350 grams, 10 pieces",
              imageURL: .init(string: "www.balam.com/img/sushi/tofu.png"),
              price: 50,
              filteredBy: [.mockedVeganFilterId])
    ]

    static let mockedDrinks: [Self] = [
        .init(id: .init(),
              title: "Belgian Beer",
              description: "Traditionally crafted Belgian beer.",
              details: "350 ml",
              imageURL: .init(string: "www.balam.com/img/drinks/belgian_beer.png"),
              price: 10,
              filteredBy: [.mockedVeganFilterId]),
        .init(id: .init(),
              title: "Kombucha",
              description: "The wellbeing elixir.",
              details: "350 ml",
              imageURL: .init(string: "www.balam.com/img/drinks/kombucha.png"),
              price: 6,
              filteredBy: []),
        .init(id: .init(),
              title: "Cider",
              description: "Get your apple game on with this sparkling drink!",
              details: "350 ml",
              imageURL: .init(string: "www.balam.com/img/drinks/cider.png"),
              price: 8,
              filteredBy: [.mockedSeasonalFilterId]),
        .init(id: .init(),
              title: "Spiced Cola",
              description: "Take it to the next level with this super tasty, spiced-up cola!",
              details: "350 ml",
              imageURL: .init(string: "www.balam.com/img/drinks/spiced_cola.png"),
              price: 12,
              filteredBy: [.mockedSpicyFilterId])
    ]

}

fileprivate extension MenuFilter {

    static let mockedData: [Self] = [
        .init(id: .mockedSpicyFilterId, title: "Spicy"),
        .init(id: .mockedVeganFilterId, title: "Vegan"),
        .init(id: .mockedSeasonalFilterId, title: "Seasonal")
    ]

}

fileprivate extension UUID {

    static let mockedSpicyFilterId: Self = .init()
    static let mockedVeganFilterId: Self = .init()
    static let mockedSeasonalFilterId: Self = .init()

}
