//
//  RequestConfiguration.swift
//  Balam
//
//  Created by Alejandro Zamudio Guajardo on 02/08/2021.
//

import Foundation

/// Configuration object that defines the properties to use for a given request.
public final class RequestConfiguration: NetworkConfiguration {

    // MARK: - Properties

    /// Specifies the HTTP method to use for a given request.
    public var method: HTTPMethod

    /// Specifies the URL to use for a given request.
    public var url: URL?

    /// Specifies the data to send (as the body) for a given request.
    public var data: Data?

    /// Specifies the query parameters to send for a given request.
    public var queryParameters: [String: LosslessStringConvertible]

    /// Yields the result of processing and combining the specified values on `url` and `baseURL`.
    /// It'll prepend `baseURL` to `url`, unless `url` is absolute.
    public var resolvedURL: URL? {
        guard let url = self.url else { return .none }
        if url.isAbsolute { return url }
        return URL(string: url.absoluteString, relativeTo: self.baseURL)
    }

    // MARK: - Inits

    /**
     Initializes a new configuration instance with the provided arguments, if any.

     All members of its parent class are initialized as either `.none` or empty.

     - Parameters:
        - method: The HTTP method to use for the request.
        - url: The URL to use for the request.
        - data: The data to send with the request (as the body of the request).
        - queryParameters: The query parameters to send with the request.
     - Returns: A fresh configuration instance.
     */
    public init(method: HTTPMethod = Defaults.method,
                url: URL? = Defaults.url,
                data: Data? = Defaults.data,
                queryParameters: [String: LosslessStringConvertible] = Defaults.queryParameters) {

        self.method = method
        self.url = url
        self.data = data
        self.queryParameters = queryParameters

        super.init(baseURL: .none,
                   headers: [:],
                   timeout: .none,
                   validateStatus: .none)
    }

}

// MARK: - Defaults

extension RequestConfiguration {

    /// Defines the default values for all class variables.
    public enum Defaults {

        /// Default value for the `method` variable.
        public static let method: HTTPMethod = .get

        /// Default value for the `url` variable.
        public static let url: URL? = .none

        /// Default value for the `data` variable.
        public static let data: Data? = .none

        /// Default value for the `queryParameters` variable.
        public static let queryParameters: [String: LosslessStringConvertible] = [:]

    }

}

// MARK: - Equatable

extension RequestConfiguration: Equatable {

    public static func == (lhs: RequestConfiguration, rhs: RequestConfiguration) -> Bool {
        lhs.baseURL == rhs.baseURL &&
            lhs.headers == rhs.headers &&
            lhs.timeout == rhs.timeout &&
            lhs.method == rhs.method &&
            lhs.url == rhs.url &&
            lhs.data == rhs.data &&
            lhs.queryParameters.isEqual(to: rhs.queryParameters) &&
            lhs.resolvedURL == rhs.resolvedURL
    }

}

private extension URL {

    /// A boolean value indicating whether a URL is absolute or not.
    var isAbsolute: Bool { self.baseURL == .none && self.scheme != .none }

}

private extension Dictionary where Key == String, Value == LosslessStringConvertible {

    /// Determines if the specified dictionary is the same as the receiver.
    func isEqual(to dictionary: [String: LosslessStringConvertible]) -> Bool {
        guard self.count == dictionary.count else { return false }
        return self.mapValues { $0.description } == dictionary.mapValues { $0.description }
    }

}
