//
//  Store.swift
//  Balam
//
//  Created by Alejandro Zamudio Guajardo on 28/07/2021.
//

import Combine
import SwiftUI

typealias Store<State> = CurrentValueSubject<State, Never>

extension Store {

    subscript<T>(keyPath: WritableKeyPath<Output, T>) -> T where T: Equatable {
        get { value[keyPath: keyPath] }
        set {
            var value = self.value
            if value[keyPath: keyPath] != newValue {
                value[keyPath: keyPath] = newValue
                self.value = value
            }
        }
    }

    func bulkUpdate(_ update: (inout Output) -> Void) {
        var value = self.value
        update(&value)
        self.value = value
    }

    func updates<T>(for keyPath: KeyPath<Output, T>) ->
        AnyPublisher<T, Failure> where T: Equatable {
        map(keyPath).removeDuplicates().eraseToAnyPublisher()
    }

}

extension ObservableObject {

    func loadableSubject<T>(_ keyPath: WritableKeyPath<Self, Loadable<T>>) -> LoadableSubject<T> {
        let defaultValue = self[keyPath: keyPath]
        return .init(get: { [weak self] in
            self?[keyPath: keyPath] ?? defaultValue
        }, set: { [weak self] in
            self?[keyPath: keyPath] = $0
        })
    }

}

extension Binding where Value: Equatable {

    typealias ValueClosure = (Value) -> Void

    func onSet(_ perform: @escaping ValueClosure) -> Self {
        .init(get: { self.wrappedValue },
              set: {
                if self.wrappedValue != $0 {
                    self.wrappedValue = $0
                }
                perform($0)
              }
        )
    }

}
