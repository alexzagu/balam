//
//  NetworkDispatcher.swift
//  Balam
//
//  Created by Alejandro Zamudio Guajardo on 02/08/2021.
//

import Combine
import Foundation

/// Contract for an instance in charge of dispatching network requests.
public protocol NetworkDispatcherProtocol: AnyObject {

    /**
     Dispatches a network request.
     - Parameter configuration: The object to configure the request.
     - Returns: A publisher containing a response or an error.
     */
    func dispatch(with configuration: RequestConfiguration) -> AnyPublisher<HTTPResponse, HTTPError>

}

// MARK: - Stub

#if DEBUG

class NetworkDispatcherStub: NetworkDispatcherProtocol {

    func dispatch(with configuration: RequestConfiguration) -> AnyPublisher<HTTPResponse, HTTPError> {
        guard let url = configuration.resolvedURL else {
            let error: HTTPError = .transport(description: "Can not perform request without a URL.")
            return Fail<HTTPResponse, HTTPError>(error: error).eraseToAnyPublisher()
        }

        guard let data = mockImageData(for: url) else {
            let placeholderData = mockImageData["www.balam.com/img/placeholder_image.png"]!
            let response = HTTPResponse(data: placeholderData, statusCode: 200, cookies: [])
            return Just.withErrorType(response, HTTPError.self)
        }

        let response = HTTPResponse(data: data, statusCode: 200, cookies: [])
        return Just.withErrorType(response, HTTPError.self)
    }

}

#endif
