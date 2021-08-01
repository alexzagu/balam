//
//  PromotionsViewModel.swift
//  Balam
//
//  Created by Alejandro Zamudio Guajardo on 31/07/2021.
//

import Combine
import Foundation

extension PromotionsView {

    class ViewModel: ObservableObject {

        @Published var promotions: Loadable<[URL]>
        @Published var title: String?

        let container: DIContainer

        init(container: DIContainer) {
            self.container = container
            _promotions = .init(initialValue: .notRequested)
            _title = .init(initialValue: "Menu")
            container.appState.updates(for: \.userData.menu.value?.title).assign(to: &$title)
        }

        func loadPromotions() {
            container
                .appServices
                .menuService
                .load(promotions: loadableSubject(\.promotions))
        }

    }

}
