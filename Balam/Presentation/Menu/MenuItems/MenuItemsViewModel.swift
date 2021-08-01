//
//  MenuItemsViewModel.swift
//  Balam
//
//  Created by Alejandro Zamudio Guajardo on 01/08/2021.
//

import Combine

extension MenuItemsView {

    class ViewModel: ObservableObject {

        let container: DIContainer
        let items: [MenuItem]

        init(container: DIContainer, items: [MenuItem]) {
            self.container = container
            self.items = items
        }

    }

}
