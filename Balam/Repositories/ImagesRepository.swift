//
//  ImagesRepository.swift
//  Balam
//
//  Created by Alejandro Zamudio Guajardo on 01/08/2021.
//

import Combine
import Foundation

protocol ImagesRepositoryProtocol {

    func loadImage(from url: URL) -> AnyPublisher<Data, Error>

}

struct ImagesRepository {

    let networkHandler: NetworkHandlerProtocol

}

// MARK: - ImagesRepositoryProtocol

extension ImagesRepository: ImagesRepositoryProtocol {

    func loadImage(from url: URL) -> AnyPublisher<Data, Error> {
        networkHandler.get(from: url)
            .map(\.data)
            .mapError { _ in ValueIsMissingError() }
            .eraseToAnyPublisher()
    }

}
