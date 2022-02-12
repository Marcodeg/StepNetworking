//
//  RequestValidator.swift
//  Networking
//
//  Created by Marco Del Giudice on 10/02/22.
//

public enum RequestValidator {
    case simple(acceptedStatusCode: Range<Int>)
    case retry(acceptedStatusCode: Range<Int>, maxRetryCount: Int, delay: Int = 1)
    
    var validator: Validator {
        switch self {
        case .simple(acceptedStatusCode: let acceptedStatusCode):
            return Validator(acceptedStatusCode: acceptedStatusCode)
        case .retry(acceptedStatusCode: let acceptedStatusCode, maxRetryCount: let maxRetryCount, _):
            return Validator(acceptedStatusCode: acceptedStatusCode, maxRetryCount: maxRetryCount)
        }
    }
}
