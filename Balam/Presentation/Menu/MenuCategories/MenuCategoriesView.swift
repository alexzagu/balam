//
//  MenuCategoriesView.swift
//  Balam
//
//  Created by Alejandro Zamudio Guajardo on 01/08/2021.
//

import SwiftUI

struct MenuCategoriesView: View {

    @ObservedObject private(set) var viewModel: ViewModel
    @State private var index: Int = 0

    var body: some View {
        VStack(spacing: 12) {
            Spacer(minLength: 9)

            ContextIndicatorView(contexts: viewModel.categories.map { $0.title },
                                 index: $index)
                .padding(.leading, 30)

            HStack(spacing: 12) {
                Text("Filters")
                    .lineLimit(1)
                    .multilineTextAlignment(.leading)
                    .font(.footnote)
                    .foregroundColor(.black.opacity(0.3))

                Spacer()
            }
            .padding(.horizontal, 30)
            .padding(.bottom, 12)

            SwiperView(elements: itemsViews, index: $index)
        }
    }

    private var itemsViews: [MenuItemsView] {
        viewModel.categories.map {
            MenuItemsView(viewModel: .init(container: viewModel.container, items: $0.items))
        }
    }

}

// MARK: - Preview

#if DEBUG

struct MenuCategoriesView_Previews: PreviewProvider {

    static var previews: some View {
        MenuCategoriesView(viewModel: .init(container: .preview,
                                            categories: Menu.mockedData.categories))
    }

}

#endif
