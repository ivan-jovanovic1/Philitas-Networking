//
//  APIHeaders.swift
//
//
//  Created by Ivan Jovanović on 01/04/2022.
//

import Foundation

public typealias Headers = [String: String]
public enum APIHeaders {
    static var headers: Headers = [:]
}

extension APIHeaders {
    static func addHeadersToRequest(_ request: inout URLRequest) {
        APIHeaders.headers.forEach {
            request.setValue($0.value, forHTTPHeaderField: $0.key)
        }
    }
    
    public static func setHeaders(_ headers: Headers) {
        APIHeaders.headers = headers
    }
}
