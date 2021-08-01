//
//  ContextualActionViewModel.swift
//  Balam
//
//  Created by Alejandro Zamudio Guajardo on 01/08/2021.
//

import Combine

extension ContextualActionView {

    class ViewModel: ObservableObject {

        @Published var routing: RootView.Routing
        @Published var badgeValue: Int = 0

        let container: DIContainer

        init(container: DIContainer) {
            self.container = container
            _routing = .init(initialValue: container.appState.value.routing.rootView)
            container.appState.updates(for: \.routing.rootView).assign(to: &$routing)
            container.appState.updates(for: \.userData.cart.count).assign(to: &$badgeValue)
        }

        func showCart() {
            container.appState[\.routing.rootView] = .init(rendering: .cart)
        }

    }

}

