//
//  NetworkConfiguration.swift
//  Balam
//
//  Created by Alejandro Zamudio Guajardo on 02/08/2021.
//

import Foundation

/// Configuration object that defines the behaviour of a network handler.
public class NetworkConfiguration {

    // MARK: - Type aliases

    /// Signature of the `validateStatus` closure.
    public typealias ValidateStatusClosure = (Int) -> Bool

    // MARK: - Properties

    /// Will be prepended to a request URL if said URL is not absolute.
    /// Useful to use with relative URLs when doing requests.
    public var baseURL: URL?

    /// Custom headers to be sent with every request.
    public var headers: [String: String]

    /// Specifies the number of seconds before a request times out.
    public var timeout: TimeInterval?

    /// Defines whether to consider an HTTP response successful or an error.
    /// If set to `.none`, all responses will be considered successful.
    public var validateStatus: ValidateStatusClosure?

    // MARK: - Inits

    /**
     Initializes a new configuration instance with the provided arguments, if any.
     - Parameters:
        - baseURL: The URL to use as base for any request.
        - headers: The headers to send with every request.
        - timeout: The number of seconds to wait to consider a request as timed out.
        - validateStatus: The closure to use to consider a request successful or an error (based on status code).
     - Returns: A fresh configuration instance.
     */
    public init(baseURL: URL? = Defaults.baseURL,
                headers: [String: String] = Defaults.headers,
                timeout: TimeInterval? = Defaults.timeout,
                validateStatus: ValidateStatusClosure? = Defaults.validateStatus) {

        self.baseURL = baseURL
        self.headers = headers
        self.timeout = timeout
        self.validateStatus = validateStatus
    }

}

// MARK: - Defaults

extension NetworkConfiguration {

    /// Defines the default values for all class variables.
    public enum Defaults {

        /// Default value for the `baseURL` variable.
        public static let baseURL: URL? = .none

        /// Default value for the `headers` variable.
        public static let headers: [String: String] = [:]

        /// Default value for the `timeout` variable.
        public static let timeout: TimeInterval? = .none

        /// Default value for the `validateStatus` variable.
        public static let validateStatus: ValidateStatusClosure = { (200...299).contains($0) }

    }

}

// MARK: - NSCopying

extension NetworkConfiguration: NSCopying {

    public func copy(with zone: NSZone? = .none) -> Any {
        NetworkConfiguration(baseURL: self.baseURL,
                                headers: self.headers,
                                timeout: self.timeout,
                                validateStatus: self.validateStatus)
    }

}
