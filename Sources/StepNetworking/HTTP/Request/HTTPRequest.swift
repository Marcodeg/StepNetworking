//
//  HTTPRequest.swift
//  Networking
//
//  Created by Marco Del Giudice on 03/02/22.
//
import Foundation


public class HTTPRequest: Requestable, Executable {
    
    internal(set) public var queryItems: [String: String]
    internal(set) public var body: Data?
    internal(set) public var headers: HTTPHeaders
    internal(set) public var url: String
    internal(set) public var pathParameters: [String]
    internal(set) public var method: HTTPMethod = .get
    internal(set) public var validator: RequestValidator
    internal(set) public var cachePolicy: URLRequest.CachePolicy
    
    init(url: String, method: HTTPMethod, headers: HTTPHeaders, queryItems: [String: String], pathParameters: [String], validator: RequestValidator, body: Data?, cachePolicy: URLRequest.CachePolicy) {
        self.url = url
        self.method = method
        self.headers = headers
        self.queryItems = queryItems
        self.pathParameters = pathParameters
        self.body = body
        self.validator = validator
        self.cachePolicy = cachePolicy
    }
    
    public static var builder: HTTPRequestBuilderURL {
        Builder()
    }
    
    public func perform<T: Decodable>(successResponse: T.Type, session: URLSession = URLSession.shared) async -> Result<T, RequestError> {
        do {
            return try await Task.retrying(priority: .background,
                                           maxRetryCount: validator.validator.maxRetryCount,
                                           retryDelay: validator.validator.retryDelay)
            { [weak self] in
                
                guard let self = self else {
                    return .failure(.undefinedError(underlyingError: nil))
                }
                
                return await self.execute(session: session,
                                          validator: self.validator.validator)
            }.value
            
        } catch let requestError as RequestError {
            return .failure(requestError)
        } catch {
            return .failure(.undefinedError(underlyingError: error))
        }
    }
    
    public func perform<T: Decodable, S: Decodable>(successResponse: T.Type, failureResponse: S.Type, session: URLSession = URLSession.shared) async -> Result<T, RequestError> {
        do {
            return try await Task.retrying(priority: .background,
                                           maxRetryCount: validator.validator.maxRetryCount,
                                           retryDelay: validator.validator.retryDelay)
            { [weak self] in
                
                guard let self = self else {
                    return .failure(.undefinedError(underlyingError: nil))
                }
                
                return await self.execute(successResponse: T.self,
                                          failureResponse: S.self,
                                          session: session,
                                          validator: self.validator.validator)
            }.value
            
        } catch let requestError as RequestError {
            return .failure(requestError)
        } catch {
            return .failure(.undefinedError(underlyingError: error))
        }
    }
    
    public func perform(session: URLSession = URLSession.shared) async -> Result<Data, RequestError> {
        do {
            return try await Task.retrying(priority: .background,
                                           maxRetryCount: validator.validator.maxRetryCount,
                                           retryDelay: validator.validator.retryDelay)
            { [weak self] in
                guard let self = self else {
                    return .failure(.undefinedError(underlyingError: nil))
                }
                
                return await self.execute(session: session,
                                          validator: self.validator.validator)
            }.value
            
        } catch let requestError as RequestError {
            return .failure(requestError)
        } catch {
            return .failure(.undefinedError(underlyingError: error))
        }
    }
}
