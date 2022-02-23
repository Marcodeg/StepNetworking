//
//  RequestValidator.swift
//  Networking
//
//  Created by Marco Del Giudice on 10/02/22.
//
import Foundation

public enum RequestValidator {
    case base(acceptedStatusCode: Range<Int>)
    case retry(acceptedStatusCode: Range<Int>, maxRetryCount: Int, delay: TimeInterval = 1)
    
    var validator: Validator {
        switch self {
        case .base(acceptedStatusCode: let acceptedStatusCode):
            return Validator(acceptedStatusCode: acceptedStatusCode)
            
        case .retry(acceptedStatusCode: let acceptedStatusCode, maxRetryCount: let maxRetryCount, delay: let delay):
            return Validator(acceptedStatusCode: acceptedStatusCode,
                             maxRetryCount: maxRetryCount,
                             retryDelay: delay)
        }
    }
}
