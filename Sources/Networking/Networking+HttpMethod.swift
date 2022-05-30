//
//  HttpMethod.swift
//
//
//  Created by Ivan Jovanović on 01/04/2022.
//

import Foundation

public enum HttpMethod: String {
    case get
    case post
    case put
    case delete

    var name: String {
        rawValue.uppercased()
    }
}
