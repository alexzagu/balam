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

    func removeItem(id: UUID) {}

    var cartTotal: Double { 0.0 }

}

// MARK: - Stub

#if DEBUG

struct CartServiceStub: CartServiceProtocol {

    func addItem(id: UUID) {}

    func removeItem(id: UUID) {}

    var cartTotal: Double { 0.0 }

}

#endif
