//
//  MenuItemView.swift
//  Balam
//
//  Created by Alejandro Zamudio Guajardo on 30/07/2021.
//

import SwiftUI

struct MenuItemView: View {

    @ObservedObject private(set) var viewModel: ViewModel

    var body: some View {
        VStack(spacing: 0) {
            image
                .frame(maxWidth: .infinity, maxHeight: 225)
                .clipped()

            VStack(spacing: 6) {
                HStack {
                    Text(viewModel.item.title)
                        .multilineTextAlignment(.leading)
                        .font(.system(size: 27, weight: .semibold, design: .default))
                        .lineLimit(1)
                        .truncationMode(.tail)

                    Spacer()
                }

                HStack {
                    Text(viewModel.item.description)
                        .multilineTextAlignment(.leading)
                        .font(.footnote)
                        .foregroundColor(.black.opacity(0.5))
                        .lineLimit(.none)
                        .truncationMode(.tail)

                    Spacer()
                }

                HStack {
                    Text(viewModel.item.details)
                        .multilineTextAlignment(.leading)
                        .font(.footnote)
                        .foregroundColor(.black.opacity(0.5))
                        .lineLimit(1)
                        .truncationMode(.tail)

                    Spacer()

                    Button(action: viewModel.addToCart, label: {
                        Text(viewModel.itemPrice)
                            .multilineTextAlignment(.center)
                            .font(.subheadline)
                            .lineLimit(1)
                            .truncationMode(.middle)
                            .padding(.vertical, 12)
                            .padding(.horizontal, 24)
                            .foregroundColor(.white)
                            .background(RoundedRectangle(cornerRadius: 45, style: .continuous).foregroundColor(.black))
                    })
                }.padding(.top, 10)
            }
            .padding(.top, 15)
            .padding(.bottom, 30)
            .padding(.horizontal, 21)
            .background(Color.white)
        }
        .cornerRadius(18)
        .padding(.horizontal, 30)
        .shadow(radius: 1)
    }

    private var image: some View {
        Group {
            if let url = viewModel.item.imageURL {
                ImageView(viewModel: .init(container: viewModel.container, url: url))
            } else {
                ImageView(viewModel: .init(container: viewModel.container,
                                           url: .init(string: "www.balam.com/img/placeholder_image.png")!,
                                           image: .loaded(value: .init(named: "placeholder-image")!)))
            }
        }
    }

}

// MARK: - Preview

#if DEBUG

struct MenuItemView_Previews: PreviewProvider {

    static var previews: some View {
        MenuItemView(viewModel: .init(container: .preview,
                                      item: Menu.mockedData.categories.first!.items.first!))
    }

}

#endif
