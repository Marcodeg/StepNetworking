//
//  Retriable.swift
//  Networking
//
//  Created by Marco Del Giudice on 09/02/22.
//

import Foundation

class Validator: Validable {
    var acceptedStatusCode: Range<Int>
    var maxRetryCount: Int
    var retryDelay: TimeInterval
    
    init(acceptedStatusCode: Range<Int>, maxRetryCount: Int = 0, retryDelay: TimeInterval = 1) {
        self.acceptedStatusCode = acceptedStatusCode
        self.maxRetryCount = maxRetryCount
        self.retryDelay = retryDelay
    }
}
