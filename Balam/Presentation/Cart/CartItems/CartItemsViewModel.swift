//
//  CartItemsViewModel.swift
//  Balam
//
//  Created by Alejandro Zamudio Guajardo on 01/08/2021.
//

import Combine

extension CartItemsView {

    class ViewModel: ObservableObject {

        @Published var items: [CartItem]

        let container: DIContainer
        private var cancelBag = CancelBag()

        init(container: DIContainer) {
            self.container = container
            _items = .init(initialValue: [])
            container
                .appState
                .updates(for: \.userData.cart)
                .sink { [weak self] _ in self?.updateItems() }
                .store(in: cancelBag)
        }

        private func updateItems() {
            items = container.appServices.cartService.condensedCart
        }

    }

}
