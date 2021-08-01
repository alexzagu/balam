//
//  RootView.swift
//  Balam
//
//  Created by Alejandro Zamudio Guajardo on 29/07/2021.
//

import SwiftUI

struct RootView: View {

    @ObservedObject private(set) var viewModel: ViewModel

    var body: some View {
        ZStack {
            content
            contextualActionButton
        }.edgesIgnoringSafeArea(.top)
    }

    private var content: AnyView {
        switch viewModel.routing.rendering {
        case .menu: return AnyView(MenuView(viewModel: .init(container: viewModel.container)))
        case .cart: return AnyView(CartView(viewModel: .init(container: viewModel.container)))
        }
    }

    private var contextualActionButton: some View {
        GeometryReader { reader in
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    ContextualActionView(viewModel: .init(container: viewModel.container))
                        .padding(.trailing, reader.size.width * 0.07)
                        .padding(.bottom, reader.size.height * 0.1)
                }
            }
        }
    }

}
