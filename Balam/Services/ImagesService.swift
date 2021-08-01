//
//  ImagesService.swift
//  Balam
//
//  Created by Alejandro Zamudio Guajardo on 29/07/2021.
//

// This is an exceptional import, shouldn't be here but it is here because of the mock images.
import UIKit

import Foundation

protocol ImagesServiceProtocol {

    func load(image: LoadableSubject<Data>, from url: URL?)

}

struct ImagesService {

    let imageRepo: ImagesRepositoryProtocol

}

// MARK: - ImagesServiceProtocol

extension ImagesService: ImagesServiceProtocol {

    func load(image: LoadableSubject<Data>, from url: URL?) {
        guard let url = url else {
            image.wrappedValue = .notRequested
            return
        }

        let cancelBag = CancelBag()
        image.wrappedValue.setLoading(with: cancelBag)

        imageRepo
            .loadImage(from: url)
            .subscribe(on: DispatchQueue.global())
            .receive(on: DispatchQueue.main)
            .sinkToLoadable { image.wrappedValue = $0 }
            .store(in: cancelBag)
    }

}

// MARK: - Stub

#if DEBUG

struct ImagesServiceStub: ImagesServiceProtocol {

    func load(image: LoadableSubject<Data>, from url: URL?) {
        guard let url = url else {
            image.wrappedValue = .notRequested
            return
        }

        guard let data = mockImageData(for: url) else {
            image.wrappedValue = .failed(ValueIsMissingError())
            return
        }

        image.wrappedValue = .loaded(value: data)
    }

}

func mockImageData(for url: URL) -> Data? {
    mockImageData[url.absoluteString]
}

let mockImageData: [String: Data] = [
    // Pizza
    "www.balam.com/img/pizza/mexican.png": UIImage(named: "mexican")!.pngData()!,
    "www.balam.com/img/pizza/4_cheese.png": UIImage(named: "4_cheese")!.pngData()!,
    "www.balam.com/img/pizza/napolitana.png": UIImage(named: "napolitana")!.pngData()!,
    "www.balam.com/img/pizza/maritime.png": UIImage(named: "maritime")!.pngData()!,
    // Sushi
    "www.balam.com/img/sushi/california.png": UIImage(named: "california")!.pngData()!,
    "www.balam.com/img/sushi/jalapeno.png": UIImage(named: "jalapeno")!.pngData()!,
    "www.balam.com/img/sushi/mango.png": UIImage(named: "mango")!.pngData()!,
    "www.balam.com/img/sushi/tofu.png": UIImage(named: "tofu")!.pngData()!,
    // Drinks
    "www.balam.com/img/drinks/belgian_beer.png": UIImage(named: "belgian_beer")!.pngData()!,
    "www.balam.com/img/drinks/kombucha.png": UIImage(named: "kombucha")!.pngData()!,
    "www.balam.com/img/drinks/cider.png": UIImage(named: "cider")!.pngData()!,
    "www.balam.com/img/drinks/spiced_cola.png": UIImage(named: "spiced_cola")!.pngData()!,
    // Placeholder
    "www.balam.com/img/placeholder_image.png": UIImage(named: "placeholder-image")!.pngData()!
]

#endif
