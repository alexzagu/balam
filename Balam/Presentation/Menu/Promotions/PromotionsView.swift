//
//  PromotionsView.swift
//  Balam
//
//  Created by Alejandro Zamudio Guajardo on 29/07/2021.
//

import SwiftUI

struct PromotionsView: View {

    @ObservedObject private(set) var viewModel: ViewModel
    @State private var index: Int = 0

    var body: some View { content }

    private var content: AnyView {
        switch viewModel.promotions {
        case .notRequested: return AnyView(notRequested)
        case .loading: return AnyView(loading)
        case let .loaded(promotions): return AnyView(loaded(promotions))
        case let .failed(error): return AnyView(failed(error))
        }
    }

}

// MARK: - Content

private extension PromotionsView {

    private var notRequested: some View {
        Text("").onAppear { viewModel.loadPromotions() }
    }

    private var loading: some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle())
    }

    private func failed(_ error: Error) -> some View {
        Text("Unable to load promotions")
            .font(.footnote)
            .multilineTextAlignment(.center)
            .lineLimit(1)
            .foregroundColor(.black.opacity(0.4))
            .padding()
    }

    private func loaded(_ promotions: [URL]) -> some View {
        GeometryReader { reader in
            ZStack {
                SwiperView(elements: promotions.map { imageView(with: $0) }, index: $index)

                VStack(spacing: 0) {
                    Text(viewModel.title ?? "Menu")
                        .foregroundColor(.white)
                        .lineLimit(.none)
                        .multilineTextAlignment(.center)
                        .font(.headline)
                        .truncationMode(.middle)
                        .frame(maxWidth: reader.size.width * 0.3, maxHeight: .infinity)

                    Spacer()

                    HStack(spacing: 8) {
                        ForEach(0..<promotions.count) { index in
                            PageIndicatorView(isFocused: Binding<Bool>(get: { self.index == index }, set: { _ in }),
                                              type: .dot,
                                              index: index)
                        }
                    }
                }
                .padding(.top, 42)
                .padding(.bottom, 30)
            }
        }
    }

    private func imageView(with url: URL) -> ImageView {
        .init(viewModel: .init(container: viewModel.container, url: url))
    }

}

// MARK: - Preview

#if DEBUG

struct PromotionsView_Previews: PreviewProvider {

    static var previews: some View {
        PromotionsView(viewModel: .init(container: .preview))
    }

}

#endif
