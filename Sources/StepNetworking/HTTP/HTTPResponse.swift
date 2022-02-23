//
//  HTTPResponse.swift
//  
//
//  Created by Marco Del Giudice on 23/02/22.
//

import Foundation

typealias HTTPResponse = Decodable

extension HTTPResponse {
    
    static func decode(_ data: Data) throws -> Self {
        try JSONDecoder().decode(self, from: data)
    }
}
