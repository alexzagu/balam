//
//  CancelBag.swift
//  Balam
//
//  Created by Alejandro Zamudio Guajardo on 28/07/2021.
//

import Combine

final class CancelBag {

    private(set) var subscriptions: Set<AnyCancellable> = []

    func cancel() { subscriptions.removeAll() }

    func store(@Builder _ cancellables: () -> [AnyCancellable]) {
        subscriptions.formUnion(cancellables())
    }

    @resultBuilder
    struct Builder {

        static func buildBlock(_ cancellables: AnyCancellable...) -> [AnyCancellable] { cancellables }

    }

}

extension AnyCancellable {

    func store(in cancelBag: CancelBag) {
        cancelBag.store { self }
    }

}
