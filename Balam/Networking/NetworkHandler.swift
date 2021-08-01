//
//  NetworkHandler.swift
//  Balam
//
//  Created by Alejandro Zamudio Guajardo on 02/08/2021.
//

import Combine
import Foundation

/// Concrete implementation of `NetworkHandlerProtocol` that uses an instance of
/// `NetworkDispatcherProtocol` to drive the networking.
public final class NetworkHandler {

    // MARK: - Properties

    /**
     Configuration object used to define network-handling behaviour and a base for request configurations.

     Once set through the `init`, the handler will ignore any changes done to this instance.
     */
    public let configuration: NetworkConfiguration

    /**
     Request and response interceptors used on every network request.

     Use these interceptors to modify request configurations before they hit the network and/or modify network responses.
     Not thread-safe at the moment so use with caution.
     */
    public let interceptors: (request: NetworkInterceptorManager<RequestConfiguration>,
                              response: NetworkInterceptorManager<HTTPResponse>)

    private let internalConfiguration: NetworkConfiguration
    private let dispatcher: NetworkDispatcherProtocol

    // MARK: - Inits

    /**
     Initializes a new handler instance with the provided arguments, if any.
     - Parameters:
        - configuration: The configuration object to define network-handling behaviour.
        - dispatcher: The object to use for dispatching network requests.
     - Returns: A fresh handler instance.
     */
    public init(configuration: NetworkConfiguration = NetworkConfiguration(),
                dispatcher: NetworkDispatcherProtocol = URLSessionDispatcher()) {

        self.configuration = configuration
        self.internalConfiguration = configuration.copy() as? NetworkConfiguration ?? .init()
        self.interceptors = (.init(), .init())
        self.dispatcher = dispatcher
    }

    // MARK: - Utility functions

    private func mergeBaseConfiguration(with requestConfiguration: RequestConfiguration) -> RequestConfiguration {
        let config = RequestConfiguration()

        config.baseURL = requestConfiguration.baseURL.map { $0 } ?? self.internalConfiguration.baseURL
        config.headers = self.internalConfiguration.headers.merging(requestConfiguration.headers) { $1 }
        config.timeout = requestConfiguration.timeout.map { $0 } ?? self.internalConfiguration.timeout
        config.validateStatus = requestConfiguration.validateStatus.map { $0 } ?? self.internalConfiguration.validateStatus
        config.method = requestConfiguration.method
        config.url = requestConfiguration.url
        config.data = requestConfiguration.data
        config.queryParameters = requestConfiguration.queryParameters

        return config
    }

    private func request(with configuration: RequestConfiguration) -> AnyPublisher<HTTPResponse, HTTPError> {
        let requestConfiguration = self.mergeBaseConfiguration(with: configuration)

        return self.interceptors.request.chain(from: requestConfiguration)
            .mapError(HTTPError.requestInterceptor(error:))
            .flatMap(self.dispatcher.dispatch(with:))
            .eraseToAnyPublisher()
    }

}

// MARK: - NetworkHandlerProtocol

extension NetworkHandler: NetworkHandlerProtocol {

    /**
     Performs a GET request.

     Merges the request configuration with the handler configuration and uses the result to dispatch the request.
     The request configuration's members take precedence over the handler configuration's.

     - Parameters:
        - url: The URL to make the request with.
        - configuration: The object to further configure the request.
     - Returns: A publisher containing a response or an error.
     */
    public func get(from url: URL,
                    with configuration: RequestConfiguration) -> AnyPublisher<HTTPResponse, HTTPError> {

        configuration.method = .get
        configuration.url = url

        return self.request(with: configuration)
    }

    /**
     Performs a POST request.

     Merges the request configuration with the handler configuration and uses the result to dispatch the request.
     The request configuration's members take precedence over the handler configuration's.

     - Parameters:
        - url: The URL to make the request with.
        - data: The optional data to send with the request (as the body).
        - configuration: The object to further configure the request.
     - Returns: A publisher containing a response or an error.
     */
    public func post(to url: URL,
                     with data: Data?,
                     and configuration: RequestConfiguration) -> AnyPublisher<HTTPResponse, HTTPError> {

        configuration.method = .post
        configuration.url = url
        configuration.data = data

        return self.request(with: configuration)
    }

    /**
     Performs a PUT request.

     Merges the request configuration with the handler configuration and uses the result to dispatch the request.
     The request configuration's members take precedence over the handler configuration's.

     - Parameters:
        - url: The URL to make the request with.
        - data: The optional data to send with the request (as the body).
        - configuration: The object to further configure the request.
     - Returns: A publisher containing a response or an error.
     */
    public func put(to url: URL,
                    with data: Data?,
                    and configuration: RequestConfiguration) -> AnyPublisher<HTTPResponse, HTTPError> {

        configuration.method = .put
        configuration.url = url
        configuration.data = data

        return self.request(with: configuration)
    }

    /**
     Performs a PATCH request.

     Merges the request configuration with the handler configuration and uses the result to dispatch the request.
     The request configuration's members take precedence over the handler configuration's.

     - Parameters:
        - url: The URL to make the request with.
        - data: The optional data to send with the request (as the body).
        - configuration: The object to further configure the request.
     - Returns: A publisher containing a response or an error.
     */
    public func patch(in url: URL,
                      with data: Data?,
                      and configuration: RequestConfiguration) -> AnyPublisher<HTTPResponse, HTTPError> {

        configuration.method = .patch
        configuration.url = url
        configuration.data = data

        return self.request(with: configuration)
    }

    /**
     Performs a DELETE request.

     Merges the request configuration with the handler configuration and uses the result to dispatch the request.
     The request configuration's members take precedence over the handler configuration's.

     - Parameters:
        - url: The URL to make the request with.
        - data: The optional data to send with the request (as the body).
        - configuration: The object to further configure the request.
     - Returns: A publisher containing a response or an error.
     */
    public func delete(in url: URL,
                       with data: Data?,
                       and configuration: RequestConfiguration) -> AnyPublisher<HTTPResponse, HTTPError> {

        configuration.method = .delete
        configuration.url = url
        configuration.data = data

        return self.request(with: configuration)
    }

}
