//
//  CartItemView.swift
//  Balam
//
//  Created by Alejandro Zamudio Guajardo on 01/08/2021.
//

import SwiftUI

struct CartItemView: View {

    @ObservedObject private(set) var viewModel: ViewModel

    var body: some View {
        content
            .frame(maxWidth: .infinity, maxHeight: 45)
            .background(Color.white)
    }

}

// MARK: - Content

extension CartItemView {

    private var content: AnyView {
        switch viewModel.menuItem {
        case .notRequested: return AnyView(notRequested)
        case .loading: return AnyView(loading)
        case let .loaded(menuItem): return AnyView(loaded(menuItem))
        case .failed: return AnyView(failed)
        }
    }

    private var notRequested: some View {
        Text("").onAppear { viewModel.loadMenuItem() }
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

    private func loaded(_ menuItem: MenuItem) -> some View {
        HStack {
            HStack(spacing: 6) {
                image(menuItem.imageURL)
                    .frame(width: 45, height: 45)
                    .clipped()

                Text(viewModel.adjustedTitle(menuItem.title))
                    .lineLimit(1)
                    .multilineTextAlignment(.leading)
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(.black)
                    .truncationMode(.tail)
            }

            Spacer()

            HStack(spacing: 6) {
                Text(viewModel.menuItemPrice)
                    .lineLimit(1)
                    .multilineTextAlignment(.leading)
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(.black)
                    .truncationMode(.head)

                Button(action: viewModel.removeFromCart) {
                    Text("X")
                        .lineLimit(1)
                        .multilineTextAlignment(.center)
                        .font(.system(size: 9, weight: .semibold))
                        .foregroundColor(.black)
                        .padding(6)
                        .background(Circle().foregroundColor(.gray).opacity(0.3))
                }
            }
        }
        .padding(.horizontal, 30)
    }

    private func image(_ url: URL?) -> ImageView {
        let container = viewModel.container

        if let url = url {
            return ImageView(viewModel: .init(container: container, url: url))
        } else {
            return ImageView(viewModel: .init(container: container,
                                              url: .init(string: "www.balam.com/img/placeholder_image.png")!,
                                              image: .loaded(value: .init(named: "placeholder-image")!)))
        }
    }

}

// MARK: - Preview

#if DEBUG

struct CartItemView_Previews: PreviewProvider {

    static var previews: some View {
        Group {
            CartItemView(viewModel: .init(container: .preview,
                                          cartItem: .init(id: .init(),
                                                          itemId: .init(),
                                                          quantity: 1)))

            CartItemView(viewModel: .init(container: .preview,
                                          cartItem: .init(id: .init(),
                                                          itemId: .init(),
                                                          quantity: 2)))
        }
    }

}

#endif
