//
//  Networking+ToQueryItems.swift
//
//
//  Created by Ivan Jovanović on 01/04/2022.
//

import Foundation

enum Query {
    static func toQueryItems(_ params: [String: Any]) -> [URLQueryItem]? {
        let filtered = params.compactMap { param -> URLQueryItem? in
            guard case Optional<Any>.some = param.value else {
                return nil
            }

            let currentValue = String(describing: param.value)
            return currentValue != "nil" ? URLQueryItem(name: param.key, value: currentValue) : nil
        }

        return filtered.isEmpty ? nil : filtered
    }
    
    static func parseParams(_ url: String, params: [String: String]) -> String {
        params.reduce(into: url) {
            $0 = $0.replacingOccurrences(of: "{\($1.key)}", with: $1.value)
        }
    }
}
