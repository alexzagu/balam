//
//  RootViewModel.swift
//  Balam
//
//  Created by Alejandro Zamudio Guajardo on 29/07/2021.
//

import Combine

extension RootView {

    class ViewModel: ObservableObject {

        @Published var routing: Routing

        let container: DIContainer

        init(container: DIContainer) {
            self.container = container
            _routing = .init(initialValue: container.appState.value.routing.rootView)
            container.appState.updates(for: \.routing.rootView).assign(to: &$routing)
        }

    }

    enum Renderable {

        case menu
        case cart

    }

    struct Routing: Equatable {

        var rendering: Renderable = .menu

    }

}
