//
//  Validable.swift
//  Networking
//
//  Created by Marco Del Giudice on 10/02/22.
//
import Foundation

enum ValidatingError: Error {
    case unexpectedResponse
    case deneiedStatusCode(code: Int)
    case requestError(failureResponse: Decodable, code: Int)
}

protocol Validable {
    var acceptedStatusCode: Range<Int> { get }

    func validate(response: URLResponse) throws
    func validate<T: Decodable>(response: URLResponse, data: Data, failureResponse: T.Type) throws
}

extension Validable {
    
    func validate(response: URLResponse) throws {
        guard let response = response as? HTTPURLResponse else {
            throw ValidatingError.unexpectedResponse
        }
        
        guard acceptedStatusCode ~= response.statusCode else {
            throw ValidatingError.deneiedStatusCode(code: response.statusCode)
        }
    }
    
    func validate<T: Decodable>(response: URLResponse, data: Data, failureResponse: T.Type) throws {
        try validate(response: response)
        
        guard let failureResponse = try? JSONDecoder().decode(T.self, from: data) else {
            throw ValidatingError.deneiedStatusCode(code: (response as? HTTPURLResponse)?.statusCode ?? 400)
        }
        
        throw ValidatingError.requestError(failureResponse: failureResponse, code: (response as? HTTPURLResponse)?.statusCode ?? 400)
    }
    
}
