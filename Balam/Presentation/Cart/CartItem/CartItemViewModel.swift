//
//  CartItemViewModel.swift
//  Balam
//
//  Created by Alejandro Zamudio Guajardo on 01/08/2021.
//

import Combine

extension CartItemView {

    class ViewModel: ObservableObject {

        @Published var menuItem: Loadable<MenuItem>

        let container: DIContainer
        let cartItem: CartItem

        init(container: DIContainer, cartItem: CartItem) {
            self.container = container
            self.cartItem = cartItem
            self._menuItem = .init(initialValue: .notRequested)
        }

        func loadMenuItem() {
            container
                .appServices
                .menuService
                .fetch(item: loadableSubject(\.menuItem),
                       with: cartItem.itemId)
        }

        func removeFromCart() {
            container
                .appServices
                .cartService
                .removeItem(id: cartItem.itemId)
        }

        func adjustedTitle(_ title: String) -> String {
            cartItem.quantity > 1 ?
                title + " (\(cartItem.quantity))" :
                title
        }

        var menuItemPrice: String {
            guard let item = menuItem.value else {
                return "USD 0.00"
            }

            let price = item.price * Double(Int(cartItem.quantity))

            return container
                    .appFormatters
                    .currencyFormatter
                    .string(from: .init(value: price)) ?? "USD 0.00"
        }

    }

}
