//
//  MenuItemsView.swift
//  Balam
//
//  Created by Alejandro Zamudio Guajardo on 01/08/2021.
//

import SwiftUI

struct MenuItemsView: View {

    @ObservedObject private(set) var viewModel: ViewModel

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 24) {
                ForEach(viewModel.items) {
                    MenuItemView(viewModel: .init(container: viewModel.container, item: $0))
                }
            }
            .background(Color.white)

            Spacer(minLength: 21)
        }
    }

}

// MARK: - Identifiable

extension MenuItemsView: Identifiable {

    var id: String {
        viewModel.items.reduce(into: "") { $0 += $1.id.uuidString }
    }

}

// MARK: - Preview

#if DEBUG

struct MenuItemsView_Previews: PreviewProvider {

    static var previews: some View {
        MenuItemsView(viewModel: .init(container: .preview,
                                       items: Menu.mockedData.categories.first!.items))
    }

}

#endif
