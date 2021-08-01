//
//  CartTotalView.swift
//  Balam
//
//  Created by Alejandro Zamudio Guajardo on 01/08/2021.
//

import SwiftUI

struct CartTotalView: View {

    @ObservedObject private(set) var viewModel: ViewModel

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 3) {
                Text("Delivery is free")
                    .lineLimit(1)
                    .multilineTextAlignment(.leading)
                    .truncationMode(.tail)
                    .font(.system(size: 12, weight: .regular))
                    .foregroundColor(.black.opacity(0.2))

                HStack(alignment: .lastTextBaseline, spacing: 12) {
                    Text("Value:")
                        .lineLimit(1)
                        .multilineTextAlignment(.leading)
                        .truncationMode(.tail)
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(.black)

                    Text(viewModel.cartTotal)
                        .lineLimit(1)
                        .multilineTextAlignment(.leading)
                        .truncationMode(.tail)
                        .font(.system(size: 30, weight: .semibold))
                        .foregroundColor(.black)
                }
            }

            Spacer()
        }
        .padding(.horizontal, 30)
        .frame(maxWidth: .infinity, maxHeight: 54)
    }

}

// MARK: - Preview

#if DEBUG

struct CartTotalView_Previews: PreviewProvider {

    static var previews: some View {
        CartTotalView(viewModel: .init(container: .preview))
    }

}

#endif
