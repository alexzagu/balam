//
//  CartView.swift
//  Balam
//
//  Created by Alejandro Zamudio Guajardo on 29/07/2021.
//

import SwiftUI

struct CartView: View {

    @ObservedObject private(set) var viewModel: ViewModel
    @State private var index: Int = 0

    var body: some View {
        VStack(spacing: 12) {
            Spacer(minLength: 27)

            HStack {
                Button(action: viewModel.showMenu) {
                    Label("Menu", systemImage: "chevron.backward")
                        .lineLimit(1)
                        .font(.footnote)
                        .foregroundColor(.black)
                }

                Spacer()
            }
            .padding(.horizontal, 30)

            ContextIndicatorView(contexts: ["Cart", "Orders", "Information"], index: $index)
                .padding(.leading, 30)
                .padding(.bottom, 12)

            SwiperView(elements: [itemsView], index: $index)
        }
    }

    private var itemsView: CartItemsView {
        .init(viewModel: .init(container: viewModel.container))
    }

}

// MARK: - Preview

#if DEBUG

struct CartView_Previews: PreviewProvider {

    static var previews: some View {
        CartView(viewModel: .init(container: .preview))
    }

}

#endif
