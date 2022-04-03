//
//  String+urlEncoded.swift
//  
//
//  Created by Ivan Jovanović on 04/04/2022.
//

import Foundation

extension String {
    /// Returns encoded string if succeeds, otherwise an empty string.
    /// This is useful if string has non-ascii values.
    var urlEncoded: String {
        addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
    }
}
