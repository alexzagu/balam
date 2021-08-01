//
//  CartService.swift
//  Balam
//
//  Created by Alejandro Zamudio Guajardo on 30/07/2021.
//

import Foundation

protocol CartServiceProtocol {

    func addItem(id: UUID)
    func removeItem(id: UUID)

    var cartTotal: Double { get }
    var condensedCart: [CartItem] { get }

}

struct CartService {

    let appState: Store<AppState>

}

// MARK: - CartServiceProtocol

extension CartService: CartServiceProtocol {

    func addItem(id: UUID) {
        appState.bulkUpdate { appState in
            let item = CartItem(id: .init(), itemId: id, quantity: 1)
            appState.userData.cart.append(item)
        }
    }

    func removeItem(id: UUID) {
        appState.bulkUpdate { appState in
            appState.userData.cart.removeAll { $0.itemId == id }
        }
    }

    var cartTotal: Double {
        guard let menu = appState[\.userData.menu].value else { return 0.0 }
        let condensedMap = condensedCartMap

        return menu.categories.flatMap { $0.items }.reduce(into: 0.0) {
            guard let quantity = condensedMap[$1.id] else { return }
            $0 += ($1.price * Double(Int(quantity)))
        }
    }

    var condensedCart: [CartItem] {
        condensedCartMap.map { .init(id: .init(), itemId: $0, quantity: $1) }
    }

    private var condensedCartMap: [UUID: UInt] {
        appState[\.userData.cart].reduce(into: [:]) { $0[$1.itemId] = ($0[$1.itemId] ?? 0) + $1.quantity }
    }

}

// MARK: - Stub

#if DEBUG

struct CartServiceStub: CartServiceProtocol {

    func addItem(id: UUID) {}

    func removeItem(id: UUID) {}

    var cartTotal: Double { 42.0 }

    var condensedCart: [CartItem] {[
        .init(id: .init(), itemId: Menu.mockedData.categories.first!.items.first!.id, quantity: 2),
        .init(id: .init(), itemId: Menu.mockedData.categories.last!.items.last!.id, quantity: 2)
    ]}

}

#endif
