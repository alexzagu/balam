//
//  MenuCategoriesViewModel.swift
//  Balam
//
//  Created by Alejandro Zamudio Guajardo on 01/08/2021.
//

import Combine

extension MenuCategoriesView {

    class ViewModel: ObservableObject {

        let container: DIContainer
        let categories: [MenuCategory]

        init(container: DIContainer, categories: [MenuCategory]) {
            self.container = container
            self.categories = categories
        }

    }

}
