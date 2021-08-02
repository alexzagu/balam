//
//  MenuView.swift
//  Balam
//
//  Created by Alejandro Zamudio Guajardo on 29/07/2021.
//

import SwiftUI

struct MenuView: View {

    @ObservedObject private(set) var viewModel: ViewModel

    var body: some View { content }

}

// MARK: - Content

extension MenuView {

    private var content: AnyView {
        switch viewModel.menu {
        case .notRequested: return AnyView(notRequested)
        case .loading: return AnyView(loading)
        case let .loaded(menu): return AnyView(loaded(menu))
        case .failed: return AnyView(failed)
        }
    }

    private var notRequested: some View {
        Text("").onAppear { viewModel.loadMenu() }
    }

    private var loading: some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle())
    }

    private var failed: some View {
        Text("Unable to load menu")
            .font(.footnote)
            .multilineTextAlignment(.center)
            .lineLimit(1)
            .foregroundColor(.black.opacity(0.4))
            .padding()
    }

    private func loaded(_ menu: Menu) -> some View {
        MenuCategoriesView(viewModel: .init(container: viewModel.container,
                                            categories: menu.categories))
    }

}

// MARK: - Preview

#if DEBUG

struct MenuView_Previews: PreviewProvider {

    static var previews: some View {
        MenuView(viewModel: .init(container: .preview))
    }

}

#endif
