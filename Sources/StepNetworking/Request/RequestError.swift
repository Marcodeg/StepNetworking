//
//  File.swift
//  
//
//  Created by Marco Del Giudice on 12/02/22.
//

import Foundation

public enum RequestError: Error  {
    case invalidURL
    case emptyData
    case validatingError(underlyingError: Error)
    // The received structure to represent the error (FailureResponse)
    case requestError(failureResponse: Decodable, code: Int)
    case undefinedError(underlyingError: Error)
}
