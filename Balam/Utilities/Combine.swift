//
//  Combine.swift
//  Balam
//
//  Created by Alejandro Zamudio Guajardo on 01/08/2021.
//

import Combine

extension Just {

    static func withErrorType<T>(_ value: Output,
                                 _ errorType: T.Type) -> AnyPublisher<Output, T> {
        Just(value)
            .setFailureType(to: T.self)
            .eraseToAnyPublisher()
    }

}

extension Publisher {

    func sinkToLoadable(_ completion: @escaping (Loadable<Output>) -> Void) -> AnyCancellable {
        sink(receiveCompletion: {
            if let error = $0.error { completion(.failed(error)) }
        }, receiveValue: { completion(.loaded(value: $0)) })
    }

}

extension Subscribers.Completion {

    var error: Failure? {
        switch self {
        case let .failure(error): return error
        default: return nil
        }
    }

}
