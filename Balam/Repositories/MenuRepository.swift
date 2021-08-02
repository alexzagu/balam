//
//  MenuRepository.swift
//  Balam
//
//  Created by Alejandro Zamudio Guajardo on 01/08/2021.
//

import Combine
import Foundation

protocol MenuRepositoryProtocol {

    func loadMenu() -> AnyPublisher<Menu, Error>
    func loadPromotions() -> AnyPublisher<[URL], Error>

}

struct MenuRepository {

    let networkHandler: NetworkHandlerProtocol

}

// MARK: - MenuRepositoryProtocol

extension MenuRepository: MenuRepositoryProtocol {

    func loadMenu() -> AnyPublisher<Menu, Error> {
        networkHandler.get(from: .init(string: "www.balam.com/menu")!)
            .map(\.data)
            .decode(type: Menu.self, decoder: JSONDecoder())
            .mapError { _ in ValueIsMissingError() }
            .eraseToAnyPublisher()
    }

    func loadPromotions() -> AnyPublisher<[URL], Error> {
        // TODO: fetch promotions from network layer once they are integreated in UI.

        let promotions: [URL] = [
            .init(string: "www.balam.com/img/placeholder_image.png")!,
            .init(string: "www.balam.com/img/placeholder_image.png")!,
            .init(string: "www.balam.com/img/placeholder_image.png")!
        ]

        return Just<[URL]>.withErrorType(promotions, Error.self)
    }

}
