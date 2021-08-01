//
//  CartItemsView.swift
//  Balam
//
//  Created by Alejandro Zamudio Guajardo on 01/08/2021.
//

import SwiftUI

struct CartItemsView: View {

    @ObservedObject private(set) var viewModel: ViewModel

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 27) {
                VStack(spacing: 12) {
                    ForEach(viewModel.items, id: \.itemId) {
                        CartItemView(viewModel: .init(container: viewModel.container, cartItem: $0))
                    }
                }

                CartTotalView(viewModel: .init(container: viewModel.container))
            }
            .background(Color.white)

            Spacer(minLength: 21)
        }
    }

}

// MARK: - Identifiable

extension CartItemsView: Identifiable {

    var id: String {
        viewModel.items.reduce(into: "") { $0 += $1.itemId.uuidString }
    }

}

// MARK: - Preview

#if DEBUG

struct CartItemsView_Previews: PreviewProvider {

    static var previews: some View {
        CartItemsView(viewModel: .init(container: .preview))
    }

}

#endif
