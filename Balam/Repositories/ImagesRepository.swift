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

struct ImagesRepository {}

// MARK: - ImagesRepositoryProtocol

extension ImagesRepository: ImagesRepositoryProtocol {

    func loadImage(from url: URL) -> AnyPublisher<Data, Error> {
        guard let data = mockImageData(for: url) else {
            return Fail<Data, Error>(error: ValueIsMissingError())
                .eraseToAnyPublisher()
        }

        return Just<Data>.withErrorType(data, Error.self)
    }

}
