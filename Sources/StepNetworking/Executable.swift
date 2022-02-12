//
//  Networking.swift
//  Networking
//
//  Created by Marco Del Giudice on 04/02/22.
//

import Foundation

protocol Executable where Self: Requestable {
    func execute<T: Decodable>(session: URLSession, validator: Validator) async -> Result<T, RequestError>
    func execute<T: Decodable, S: Decodable>(successResponse: T.Type, failureResponse: S.Type, session: URLSession, validator: Validator) async -> Result<T, RequestError>
    func execute(session: URLSession, validator: Validator) async -> Result<Data, RequestError>
}

extension Executable {
    
    func execute<T: Decodable>(session: URLSession, validator: Validator) async -> Result<T, RequestError> {
        do {
            let urlRequest = try getURLRequest()
            let (data, response) = try await session.data(for: urlRequest)
            try validator.validate(response: response)
            return .success(try decodeResponse(data))
        } catch let validatingError as ValidatingError {
            return .failure(.validatingError(underlyingError: validatingError))
        } catch {
            return .failure(.undefinedError(underlyingError: error))
        }
    }
    
    func execute<T: Decodable, S: Decodable>(successResponse: T.Type, failureResponse: S.Type, session: URLSession, validator: Validator) async -> Result<T, RequestError> {
        do {
            let urlRequest = try getURLRequest()
            let (data, response) = try await session.data(for: urlRequest)
            try validator.validate(response: response, data: data, failureResponse: S.self)
            return .success(try decodeResponse(data))
        } catch let validatingError as ValidatingError {
            return .failure(.validatingError(underlyingError: validatingError))
        } catch {
            return .failure(.undefinedError(underlyingError: error))
        }
    }
    
    func execute(session: URLSession, validator: Validator) async -> Result<Data, RequestError> {
        do {
            let urlRequest = try getURLRequest()
            let (data, response) = try await session.data(for: urlRequest)
            try validator.validate(response: response)
            return .success(data)
        } catch let validatingError as ValidatingError {
            return .failure(.validatingError(underlyingError: validatingError))
        } catch {
            return .failure(.undefinedError(underlyingError: error))
        }
    }
    
    func decodeResponse<T: Decodable>(_ data: Data) throws -> T {
        try JSONDecoder().decode(T.self, from: data)
    }
    
}
