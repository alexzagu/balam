//
//  CartViewModel.swift
//  Balam
//
//  Created by Alejandro Zamudio Guajardo on 01/08/2021.
//

import Combine

extension CartView {

    class ViewModel: ObservableObject {

        let container: DIContainer

        init(container: DIContainer) {
            self.container = container
        }

        func showMenu() {
            container.appState[\.routing.rootView] = .init(rendering: .menu)
        }

    }

}
