//
//  MenuItemViewModel.swift
//  Balam
//
//  Created by Alejandro Zamudio Guajardo on 30/07/2021.
//

import Combine
import Foundation

extension MenuItemView {

    class ViewModel: ObservableObject {

        let container: DIContainer
        let item: MenuItem

        var itemPrice: String {
            container
                .appFormatters
                .currencyFormatter
                .string(from: .init(value: item.price)) ?? "USD 0.00"
        }

        init(container: DIContainer, item: MenuItem) {
            self.container = container
            self.item = item
        }

        func addToCart() {
            container.appServices.cartService.addItem(id: item.id)
        }

    }

}
