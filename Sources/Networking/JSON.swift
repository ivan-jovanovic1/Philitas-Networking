//
//  NetworkingCoders.swift
//  
//
//  Created by Ivan Jovanović on 30/05/2022.
//

import Foundation


enum JSON {
    static let encoder: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        return encoder
    }()
    
    static let decoder = JSONDecoder()
}
