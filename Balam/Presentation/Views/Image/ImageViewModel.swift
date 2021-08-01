//
//  ImageViewModel.swift
//  Balam
//
//  Created by Alejandro Zamudio Guajardo on 01/08/2021.
//

import Combine
import Foundation
import UIKit

extension ImageView {

    class ViewModel: ObservableObject {

        let url: URL
        @Published private var imageData: Loadable<Data>
        @Published var image: Loadable<UIImage>

        let container: DIContainer
        private var cancelBag = CancelBag()

        init(container: DIContainer, url: URL, image: Loadable<UIImage> = .notRequested) {
            self.container = container
            self.url = url
            self._imageData = .init(initialValue: .notRequested)
            self._image = .init(initialValue: image)
            self.$imageData
                .dropFirst()
                .sink { [weak self] in self?.mapImage(from: $0) }
                .store(in: cancelBag)
        }

        private func mapImage(from data: Loadable<Data>) {
            switch image {
            case .loaded: return
            default: break
            }

            image = data.map { UIImage(data: $0) ?? UIImage() }
        }

        func loadImage() {
            container
                .appServices
                .imagesService
                .load(image: loadableSubject(\.imageData), from: url)
        }

    }

}
