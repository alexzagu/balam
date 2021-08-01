//
//  URLSessionDispatcher.swift
//  Balam
//
//  Created by Alejandro Zamudio Guajardo on 02/08/2021.
//

import Combine
import Foundation

/// Concrete implementation of `NetworkDispatcherProtocol` that uses `URLSession` to drive the networking.
public final class URLSessionDispatcher {

    // MARK: - Properties

    private let session: URLSession

    // MARK: - Inits

    /**
     Initializes a new dispatcher instance with the provided argument, if any.
     - Parameter session: The `URLSession` instance for dispatching requests, or `URLSession.shared`.
     - Returns: A fresh dispatcher instance.
     */
    public init(session: URLSession = .shared) {
        self.session = session
    }

    // MARK: - Functions

    private func mapHTTPResponse(from data: Data,
                                 and response: URLResponse,
                                 with configuration: RequestConfiguration) throws -> HTTPResponse {

        guard let response = response as? HTTPURLResponse else {
            throw HTTPError.transport(description: "Can not process non-http responses.")
        }

        let statusCode = response.statusCode
        let success = configuration.validateStatus?(statusCode) ?? true

        guard success else { throw HTTPError.server(data: data, statusCode: statusCode) }

        let cookies = self.mapHTTPCookies(from: response)

        return HTTPResponse(data: data, statusCode: statusCode, cookies: cookies)
    }

    private func mapHTTPCookies(from response: HTTPURLResponse) -> [HTTPCookie] {
        guard let url = response.url,
              let headers = response.allHeaderFields as? [String: String] else { return [] }

        return HTTPCookie.cookies(withResponseHeaderFields: headers, for: url)
    }

}

// MARK: - NetworkDispatcherProtocol

extension URLSessionDispatcher: NetworkDispatcherProtocol {

    public func dispatch(with configuration: RequestConfiguration) -> AnyPublisher<HTTPResponse, HTTPError> {

        guard let url = configuration.resolvedURL else {
            let error: HTTPError = .transport(description: "Can not perform request without a URL.")
            return Fail<HTTPResponse, HTTPError>(error: error).eraseToAnyPublisher()
        }

        var request = URLRequest(url: url)
        request.httpMethod = configuration.method.rawValue
        request.httpBody = configuration.data
        request.allHTTPHeaderFields = configuration.headers

        if let timeout = configuration.timeout { request.timeoutInterval = timeout }

        return self.session.dataTaskPublisher(for: request)
            .tryMap { try self.mapHTTPResponse(from: $0, and: $1, with: configuration) }
            .mapError { ($0 as? HTTPError) ?? .transport(description: $0.localizedDescription) }
            .eraseToAnyPublisher()
    }

}
