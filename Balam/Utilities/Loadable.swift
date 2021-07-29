//
//  Loadable.swift
//  Balam
//
//  Created by Alejandro Zamudio Guajardo on 28/07/2021.
//

import Foundation
import SwiftUI

typealias LoadableSubject<T> = Binding<Loadable<T>>

enum Loadable<T> {

    case notRequested
    case loading(latest: T?, cancelBag: CancelBag)
    case loaded(value: T)
    case failed(Error)

    var value: T? {
        switch self {
        case let .loaded(value): return value
        case let .loading(latest, _): return latest
        default: return nil
        }
    }

    var error: Error? {
        switch self {
        case let .failed(error): return error
        default: return nil
        }
    }

}

extension Loadable {

    mutating func setLoading(with cancelBag: CancelBag) {
        self = .loading(latest: value, cancelBag: cancelBag)
    }

    func map<V>(_ transform: (T) throws -> V) -> Loadable<V> {
        do {
            switch self {
            case .notRequested: return .notRequested
            case let .failed(error): return .failed(error)
            case let .loading(latest, cancelBag):
                return .loading(latest: try latest.map { try transform($0) },
                                cancelBag: cancelBag)
            case let .loaded(value):
                return .loaded(value: try transform(value))
            }
        } catch {
            return .failed(error)
        }
    }

}

protocol OptionalValue {

    associatedtype Wrapped
    func unwrap() throws -> Wrapped

}

struct ValueIsMissingError: Error {

    var localizedDescription: String { "Data is missing..." }

}

extension Optional: OptionalValue {

    func unwrap() throws -> Wrapped {
        switch self {
        case let .some(value): return value
        case .none: throw ValueIsMissingError()
        }
    }

}

extension Loadable where T: OptionalValue {

    func unwrap() -> Loadable<T.Wrapped> {
        map { try $0.unwrap() }
    }

}

extension Loadable: Equatable where T: Equatable {

    static func == (lhs: Loadable<T>, rhs: Loadable<T>) -> Bool {
        switch (lhs, rhs) {
        case (.notRequested, .notRequested): return true
        case let (.loading(lhsV, _), .loading(rhsV, _)): return lhsV == rhsV
        case let (.loaded(lhsV), .loaded(rhsV)): return lhsV == rhsV
        case let (.failed(lhsE), .failed(rhsE)):
            return lhsE.localizedDescription == rhsE.localizedDescription
        default: return false
        }
    }

}
