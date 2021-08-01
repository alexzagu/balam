//
//  MenuItemsView.swift
//  Balam
//
//  Created by Alejandro Zamudio Guajardo on 01/08/2021.
//

import SwiftUI

struct MenuItemsView: View {

    @ObservedObject private(set) var viewModel: ViewModel
    @State private var height: CGFloat?

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 24) {
                ForEach(viewModel.items) {
                    MenuItemView(viewModel: .init(container: viewModel.container, item: $0))
                }
            }
            .background(Color.white)
            .background(
                GeometryReader {
                    Color.clear.preference(key: HeightKey.self, value: $0.size.height)
                }
            )
            .onPreferenceChange(HeightKey.self) { height = $0 }
            .frame(maxWidth: .infinity, maxHeight: height)

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

// MARK: - Definitions

extension MenuItemsView {

    struct HeightKey: PreferenceKey {

        static var defaultValue: CGFloat? { nil }

        static func reduce(value: inout CGFloat?, nextValue: () -> CGFloat?) {
            value = value ?? nextValue()
        }

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
