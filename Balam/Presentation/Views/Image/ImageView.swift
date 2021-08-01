//
//  ImageView.swift
//  Balam
//
//  Created by Alejandro Zamudio Guajardo on 29/07/2021.
//

import Combine
import SwiftUI

struct ImageView: View {

    @ObservedObject private(set) var viewModel: ViewModel

    var body: some View { content }

    private var content: AnyView {
        switch viewModel.image {
        case .notRequested: return AnyView(notRequested)
        case .loading: return AnyView(loading)
        case let .loaded(image): return AnyView(loaded(image))
        case let .failed(error): return AnyView(failed(error))
        }
    }

}

// MARK: - Content

private extension ImageView {

    private var notRequested: some View {
        Text("").onAppear { viewModel.loadImage() }
    }

    private var loading: some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle())
    }

    private func loaded(_ image: UIImage) -> some View {
        Image(uiImage: image)
            .resizable()
            .aspectRatio(contentMode: .fill)
    }

    private func failed(_ error: Error) -> some View {
        Text("Unable to load image")
            .font(.footnote)
            .multilineTextAlignment(.center)
            .lineLimit(1)
            .foregroundColor(.black.opacity(0.4))
            .padding()
    }

}

// MARK: - Identifiable

extension ImageView: Identifiable {

    var id: String {
        viewModel.url.absoluteString
    }

}

// MARK: - Preview

#if DEBUG

struct ImageView_Previews: PreviewProvider {

    static var previews: some View {
        Group {
            ImageView(viewModel: .init(container: .preview,
                                       url: .init(string: "www.balam.com/img/placeholder_image.png")!,
                                       image: .loaded(value: .init(named: "placeholder-image")!)))

            ImageView(viewModel: .init(container: .preview,
                                       url: .init(string: "www.balam.com/img/placeholder_image.png")!,
                                       image: .loading(latest: .none, cancelBag: .init())))

            ImageView(viewModel: .init(container: .preview,
                                       url: .init(string: "www.balam.com/img/placeholder_image.png")!,
                                       image: .failed(ValueIsMissingError())))
        }
    }

}

#endif
