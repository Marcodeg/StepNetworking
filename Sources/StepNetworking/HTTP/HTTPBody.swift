//
//  File.swift
//  
//
//  Created by Marco Del Giudice on 20/02/22.
//

import Foundation

typealias HTTPBody = Encodable

extension HTTPBody {
    func encode() -> Data? {
        try? JSONEncoder().encode(self)
    }
}
