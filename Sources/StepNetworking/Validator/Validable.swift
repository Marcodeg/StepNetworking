//
//  Validable.swift
//  Networking
//
//  Created by Marco Del Giudice on 10/02/22.
//

enum ValidatingError: Error {
    case unexpectedResponse
    case deneiedStatusCode(code: Int)
    case needRetry
    case requestError(failureResponse: Decodable, code: Int)
}

protocol Validable {
    var acceptedStatusCode: Range<Int> { get set }
    var maxRetryCount: Int { get set }
    
    func validate(response: URLResponse) throws
    func validate<T: Decodable>(response: URLResponse, data: Data, failureResponse: T.Type) throws
}

extension Validable {
    
    func validate(response: URLResponse) throws {
        guard let response = response as? HTTPURLResponse else {
            if maxRetryCount > 0 {
                throw ValidatingError.needRetry
            } else  {
                throw ValidatingError.unexpectedResponse
            }
        }
        
        guard acceptedStatusCode ~= response.statusCode else {
            if maxRetryCount > 0 {
                throw ValidatingError.needRetry
            } else  {
                throw ValidatingError.deneiedStatusCode(code: response.statusCode)
            }
        }
    }
    
    func validate<T: Decodable>(response: URLResponse, data: Data, failureResponse: T.Type) throws {
        try validate(response: response)
        
        guard let failureResponse = try? JSONDecoder().decode(T.self, from: data) else {
            if maxRetryCount > 0 {
                throw ValidatingError.needRetry
            } else  {
                throw ValidatingError.deneiedStatusCode(code: (response as? HTTPURLResponse)?.statusCode ?? 400)
            }
        }
        throw ValidatingError.requestError(failureResponse: failureResponse, code: (response as? HTTPURLResponse)?.statusCode ?? 400)
    }
    
}
