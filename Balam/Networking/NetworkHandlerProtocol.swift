//
//  NetworkHandlerProtocol.swift
//  Balam
//
//  Created by Alejandro Zamudio Guajardo on 02/08/2021.
//

import Combine
import Foundation

/// Contract for an instance in charge of handling all network-related tasks.
public protocol NetworkHandlerProtocol: AnyObject {

    /// A closure that receives a `RequestConfiguration` instance as argument and returns a `Future`.
    typealias RequestInterceptor = NetworkInterceptorManager<RequestConfiguration>.Interceptor

    /// A closure that receives a `HTTPResponse` instance as argument and returns a `Future`.
    typealias ResponseInterceptor = NetworkInterceptorManager<HTTPResponse>.Interceptor

    /// Configuration object used to define network-handling behaviour and a base for request configurations.
    var configuration: NetworkConfiguration { get }

    /**
     Request and response interceptors used on every network request.

     Use these interceptors to modify request configurations before they hit the network and/or modify network responses.
     Not thread-safe at the moment so use with caution.
     */
    var interceptors: (request: NetworkInterceptorManager<RequestConfiguration>,
                       response: NetworkInterceptorManager<HTTPResponse>) { get }

    /**
     Performs a GET request.
     - Parameter url: The URL to make the request with.
     - Returns: A publisher containing a response or an error.
     */
    func get(from url: URL) -> AnyPublisher<HTTPResponse, HTTPError>

    /**
     Performs a GET request.
     - Parameters:
        - url: The URL to make the request with.
        - configuration: The object to further configure the request.
     - Returns: A publisher containing a response or an error.
     */
    func get(from url: URL,
             with configuration: RequestConfiguration) -> AnyPublisher<HTTPResponse, HTTPError>

    /**
     Performs a POST request.
     - Parameters:
        - url: The URL to make the request with.
        - data: The optional data to send with the request (as the body).
     - Returns: A publisher containing a response or an error.
     */
    func post(to url: URL, with data: Data?) -> AnyPublisher<HTTPResponse, HTTPError>

    /**
     Performs a POST request.
     - Parameters:
        - url: The URL to make the request with.
        - data: The optional data to send with the request (as the body).
        - configuration: The object to further configure the request.
     - Returns: A publisher containing a response or an error.
     */
    func post(to url: URL,
              with data: Data?,
              and configuration: RequestConfiguration) -> AnyPublisher<HTTPResponse, HTTPError>

    /**
     Performs a PUT request.
     - Parameters:
        - url: The URL to make the request with.
        - data: The optional data to send with the request (as the body).
     - Returns: A publisher containing a response or an error.
     */
    func put(to url: URL, with data: Data?) -> AnyPublisher<HTTPResponse, HTTPError>

    /**
     Performs a PUT request.
     - Parameters:
        - url: The URL to make the request with.
        - data: The optional data to send with the request (as the body).
        - configuration: The object to further configure the request.
     - Returns: A publisher containing a response or an error.
     */
    func put(to url: URL,
             with data: Data?,
             and configuration: RequestConfiguration) -> AnyPublisher<HTTPResponse, HTTPError>

    /**
     Performs a PATCH request.
     - Parameters:
        - url: The URL to make the request with.
        - data: The optional data to send with the request (as the body).
     - Returns: A publisher containing a response or an error.
     */
    func patch(in url: URL, with data: Data?) -> AnyPublisher<HTTPResponse, HTTPError>

    /**
     Performs a PATCH request.
     - Parameters:
        - url: The URL to make the request with.
        - data: The optional data to send with the request (as the body).
        - configuration: The object to further configure the request.
     - Returns: A publisher containing a response or an error.
     */
    func patch(in url: URL,
               with data: Data?,
               and configuration: RequestConfiguration) -> AnyPublisher<HTTPResponse, HTTPError>

    /**
     Performs a DELETE request.
     - Parameters:
        - url: The URL to make the request with.
        - data: The optional data to send with the request (as the body).
     - Returns: A publisher containing a response or an error.
     */
    func delete(in url: URL, with data: Data?) -> AnyPublisher<HTTPResponse, HTTPError>

    /**
     Performs a DELETE request.
     - Parameters:
        - url: The URL to make the request with.
        - data: The optional data to send with the request (as the body).
        - configuration: The object to further configure the request.
     - Returns: A publisher containing a response or an error.
     */
    func delete(in url: URL,
                with data: Data?,
                and configuration: RequestConfiguration) -> AnyPublisher<HTTPResponse, HTTPError>

}

public extension NetworkHandlerProtocol {

    /**
     Performs a GET request using a default request configuration.
     - Parameter url: The URL to make the request with.
     - Returns: A publisher containing a response or an error.
     */
    func get(from url: URL) -> AnyPublisher<HTTPResponse, HTTPError> {
        self.get(from: url, with: RequestConfiguration())
    }

    /**
     Performs a POST request using a default request configuration.
     - Parameters:
        - url: The URL to make the request with.
        - data: The optional data to send with the request (as the body).
     - Returns: A publisher containing a response or an error.
     */
    func post(to url: URL, with data: Data? = .none) -> AnyPublisher<HTTPResponse, HTTPError> {
        self.post(to: url, with: data, and: RequestConfiguration())
    }

    /**
     Performs a PUT request using a default request configuration.
     - Parameters:
        - url: The URL to make the request with.
        - data: The optional data to send with the request (as the body).
     - Returns: A publisher containing a response or an error.
     */
    func put(to url: URL, with data: Data? = .none) -> AnyPublisher<HTTPResponse, HTTPError> {
        self.put(to: url, with: data, and: RequestConfiguration())
    }

    /**
     Performs a PATCH request using a default request configuration.
     - Parameters:
        - url: The URL to make the request with.
        - data: The optional data to send with the request (as the body).
     - Returns: A publisher containing a response or an error.
     */
    func patch(in url: URL, with data: Data? = .none) -> AnyPublisher<HTTPResponse, HTTPError> {
        self.patch(in: url, with: data, and: RequestConfiguration())
    }

    /**
     Performs a DELETE request using a default request configuration.
     - Parameters:
        - url: The URL to make the request with.
        - data: The optional data to send with the request (as the body).
     - Returns: A publisher containing a response or an error.
     */
    func delete(in url: URL, with data: Data? = .none) -> AnyPublisher<HTTPResponse, HTTPError> {
        self.delete(in: url, with: data, and: RequestConfiguration())
    }

}

/// The method to use when doing a network request.
public enum HTTPMethod: String, CustomStringConvertible, CaseIterable {

    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"

    public var description: String { self.rawValue }

}

/// The response received from a server after doing a network request.
public struct HTTPResponse: Equatable {

    /// The data received from the server (as the body).
    public let data: Data

    /// The status code of the response.
    public let statusCode: Int

    /// The cookies, if any, received from the server.
    public let cookies: [HTTPCookie]

    /**
     Initializes a new response instance with the provided arguments.
     - Parameters:
        - data: The data representing the body of the response.
        - statusCode: The code representing the status of the response.
     - Returns: A fresh response instance.
     */
    public init(data: Data, statusCode: Int, cookies: [HTTPCookie]) {
        self.data = data
        self.statusCode = statusCode
        self.cookies = cookies
    }

}

/// The error received after doing a network request.
public enum HTTPError: Error, Equatable {

    case transport(description: String)
    case requestInterceptor(error: Error)
    case responseInterceptor(error: Error)
    case server(data: Data, statusCode: Int)

    public static func == (lhs: HTTPError, rhs: HTTPError) -> Bool {
        switch (lhs, rhs) {
        case (let .transport(descriptionLHS), let .transport(descriptionRHS)):
            return descriptionLHS == descriptionRHS
        case (let .requestInterceptor(errorLHS), let .requestInterceptor(errorRHS)):
            return String(reflecting: errorLHS) == String(reflecting: errorRHS)
        case (let .responseInterceptor(errorLHS), let .responseInterceptor(errorRHS)):
            return String(reflecting: errorLHS) == String(reflecting: errorRHS)
        case (let .server(dataLHS, statusCodeLHS), let .server(dataRHS, statusCodeRHS)):
            return (dataLHS == dataRHS) && (statusCodeLHS == statusCodeRHS)
        default:
            return false
        }
    }

}
