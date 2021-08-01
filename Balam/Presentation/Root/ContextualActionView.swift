//
//  ContextualActionView.swift
//  Balam
//
//  Created by Alejandro Zamudio Guajardo on 29/07/2021.
//

import SwiftUI

struct ContextualActionView: View {

    @ObservedObject private(set) var viewModel: ViewModel

    var body: some View {
        content
    }

    private var content: AnyView {
        switch viewModel.routing.rendering {
        case .menu : return AnyView(menuAction)
        case .cart: return AnyView(cartAction)
        }
    }

    private var menuAction: some View {
        Button(action: viewModel.showCart) {
            action(with: .cart)
        }
    }

    private var cartAction: some View {
        Button(action: {}) {
            action(with: .pay)
        }
    }

    private func action(with icon: Icon) -> some View {
        ZStack {
            Image(icon.name)
                .resizable()
                .frame(width: 18, height: 18)
                .padding(12)
                .background(Circle().foregroundColor(.white).shadow(radius: 3))

            if viewModel.routing.rendering == .menu && viewModel.badgeValue > 0 {
                VStack(alignment: .trailing) {
                    HStack(alignment: .top, spacing: 0) {
                        Spacer()

                        Text("\(viewModel.badgeValue)")
                            .foregroundColor(.white)
                            .lineLimit(1)
                            .multilineTextAlignment(.center)
                            .font(.system(size: 8))
                            .padding(3)
                            .background(Circle().foregroundColor(.green))
                    }

                    Spacer()
                }
            }
        }.frame(width: 30, height: 30)
    }

}

// MARK: - Icon

private extension ContextualActionView {

    enum Icon {

        case cart
        case pay

        var name: String {
            switch self {
            case .cart: return "cart-icon"
            case .pay: return "pay-icon"
            }
        }

    }

}

// MARK: - ViewModel

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
