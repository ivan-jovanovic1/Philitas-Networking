//
//  BaseURL.swift
//
//
//  Created by Ivan Jovanović on 31/03/2022.
//

import Foundation

public protocol BaseURL {
    /// Represents the base url for the request, e.g. example.com/v3".
    var baseURL: String { get }
}

extension BaseURL where Self: RawRepresentable, Self.RawValue == String {
    /// Represesnts the full url for the request, e.g. "example.com/v3/posts"
    public var fullURL: String {
        baseURL + rawValue
    }
}
