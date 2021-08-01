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

struct MenuRepository {}

// MARK: - MenuRepositoryProtocol

extension MenuRepository: MenuRepositoryProtocol {

    func loadMenu() -> AnyPublisher<Menu, Error> {
        Just<Menu>.withErrorType(.mockedData, Error.self)
    }

    func loadPromotions() -> AnyPublisher<[URL], Error> {
        let promotions: [URL] = [
            .init(string: "www.balam.com/img/placeholder_image.png")!,
            .init(string: "www.balam.com/img/placeholder_image.png")!,
            .init(string: "www.balam.com/img/placeholder_image.png")!
        ]

        return Just<[URL]>.withErrorType(promotions, Error.self)
    }

}
