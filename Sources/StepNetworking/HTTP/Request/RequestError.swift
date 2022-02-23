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
    case undefinedError(underlyingError: Error?)
}
