//
//  Response.swift
//
//
//  Created by Ivan Jovanović on 02/04/2022.
//

import Foundation
public enum Response {
    /// Verifies the API response.
    /// - Parameter response: An API response.
    /// - Returns: An error of type `Networking.NetworkError` if not valid, nil otherwise.
    static func verify(response: URLResponse) -> NetworkError? {
        guard let response = response as? HTTPURLResponse else {
            return .notHttpResponse
        }
        
        let range = 200...299
        return range.contains(response.statusCode) ? nil : .unexpectedStatusCode(code: response.statusCode)
    }
}


