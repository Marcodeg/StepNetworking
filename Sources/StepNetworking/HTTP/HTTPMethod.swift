//
//  HTTPMethos.swift
//  Networking
//
//  Created by Marco Del Giudice on 02/12/21.
//

import Foundation

public enum HTTPMethod: Equatable {
    case get
    case post
    case put
    case patch
    case delete
    case custom(String)
    
    var stringValue: String {
        switch self {
        case .get:
            return "GET"
        case .post:
            return "POST"
        case .put:
            return "PUT"
        case .patch:
            return "PATCH"
        case .delete:
            return "DELETE"
        case .custom(let val):
            return val
        }
    }
}
