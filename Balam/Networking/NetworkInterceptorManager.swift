//
//  NetworkInterceptorManager.swift
//  Balam
//
//  Created by Alejandro Zamudio Guajardo on 02/08/2021.
//

import Combine

/// Manages and chains together a sequence of interceptors that pass along an `Intercepted` instance throughout the chain.
public final class NetworkInterceptorManager<Intercepted> {

    // MARK: - Type aliases

    /**
     A closure that receives an `Intercepted` instance as argument and returns a `Future`.

     The closure can do whatever it wants with the `Intercepted` instance and
     needs to return it through the `Future` or fail with an `Error`.
     The closure can be asynchronous due to the usage of the `Future`.
     */
    public typealias Interceptor = (Intercepted) -> Future<Intercepted, Error>

    // MARK: - Properties

    /// Sequence of interceptors to chain.
    internal private(set) var interceptors = [Interceptor]()

    // MARK: - Functions

    /**
     Adds an `Interceptor` closure to the interceptor sequence `interceptors`.
     - Parameter interceptor: The closure to add to the interceptor sequence.
     */
    public func add(interceptor: @escaping Interceptor) {
        self.interceptors.append(interceptor)
    }

    /**
     Generates a type-erased publisher that represents the chain of all interceptors present in the
     interceptor sequence `interceptors`, using an `Intercepted` instance as the root of the chain.

     If the interceptor sequence `interceptors` is empty, this method generates a type-erased
     publisher that directly emits the `Intercepted` instance.

     - Parameter intercepted: The instance to use as the root of the chain of interceptors. It'll be passed throughout the chain.
     - Returns: A type-erased publisher representing the chain of all interceptors.
     */
    internal func chain(from intercepted: Intercepted) -> AnyPublisher<Intercepted, Error> {
        let chain = Just(intercepted).setFailureType(to: Error.self).eraseToAnyPublisher()

        return self.interceptors.reduce(chain) { chain, interceptor in
            chain.flatMap(interceptor).eraseToAnyPublisher()
        }
    }

}
