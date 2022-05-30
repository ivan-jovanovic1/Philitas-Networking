//
//  BaseURL.swift
//
//
//  Created by Ivan Jovanović on 31/03/2022.
//

import Foundation

public protocol BaseURL: RawRepresentable where RawValue == String {
    /// Represents the base url for the request, e.g. example.com/v3".
    var baseURL: String { get }
}

extension BaseURL {
    /// Represesnts the full url for the request, e.g. "example.com/v3/posts"
    public var fullURL: String {
        baseURL + rawValue
    }
}
