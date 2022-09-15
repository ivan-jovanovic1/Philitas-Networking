//
//  BaseURL.swift
//
//
//  Created by Ivan Jovanović on 31/03/2022.
//

import Foundation

public protocol BaseURL where Self: RawRepresentable, Self.RawValue == String {
    var baseURL: String { get }
}

extension BaseURL {
    var fullURL: String {
        baseURL + rawValue
    }
}

