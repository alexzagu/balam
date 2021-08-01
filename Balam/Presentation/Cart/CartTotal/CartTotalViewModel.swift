//
//  CartTotalViewModel.swift
//  Balam
//
//  Created by Alejandro Zamudio Guajardo on 01/08/2021.
//

import Combine

extension CartTotalView {

    class ViewModel: ObservableObject {

        @Published var cartTotal: String

        let container: DIContainer
        private var cancelBag = CancelBag()
        private static let defaultTotal = "USD 0.00"

        init(container: DIContainer) {
            self.container = container
            _cartTotal = .init(initialValue: Self.defaultTotal)
            container
                .appState
                .updates(for: \.userData.cart)
                .sink { [weak self] _ in self?.cartTotal = self?.latestCartTotal ?? Self.defaultTotal }
                .store(in: cancelBag)
        }

        private var latestCartTotal: String {
            let total = container.appServices.cartService.cartTotal
            return container
                .appFormatters
                .currencyFormatter
                .string(from: .init(value: total)) ?? Self.defaultTotal
        }

    }

}
