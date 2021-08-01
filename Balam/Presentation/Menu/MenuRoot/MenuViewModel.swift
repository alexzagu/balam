//
//  MenuViewModel.swift
//  Balam
//
//  Created by Alejandro Zamudio Guajardo on 01/08/2021.
//

import Combine

extension MenuView {

    class ViewModel: ObservableObject {

        @Published var menu: Loadable<Menu>

        let container: DIContainer

        init(container: DIContainer) {
            self.container = container
            self._menu = .init(initialValue: .notRequested)
        }

        func loadMenu() {
            container
                .appServices
                .menuService
                .load(menu: loadableSubject(\.menu))
        }

    }

}
