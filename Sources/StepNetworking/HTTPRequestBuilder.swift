//
//  HTTPRequestBuilder.swift
//  Networking
//
//  Created by Marco Del Giudice on 06/02/22.
//

import Foundation

public protocol HTTPRequestBuilderURL {
    func withURL(_ url: String) -> HTTPRequestBuilderMethod
}

public protocol HTTPRequestBuilderMethod {
    func withHTTPMethod(_ method: HTTPMethod) -> HTTPRequestBuilder
}

public protocol HTTPRequestBuilder {
    func withHeaders(_ headers: [String: String]) -> HTTPRequestBuilder
    func withQueryItems(_ items: [String: String]) -> HTTPRequestBuilder
    func withBody<T: Encodable>(_ body: T) -> HTTPRequestBuilder
    func withPathParameters(_ parameters: [String]) -> HTTPRequestBuilder
    func withValidator(_ validator: RequestValidator) -> HTTPRequestBuilder 
    func withCachePolicy(_ policy: URLRequest.CachePolicy) -> HTTPRequestBuilder
    func build() -> HTTPRequest
    
}

extension HTTPRequest {
    
    public class Builder: HTTPRequestBuilderURL, HTTPRequestBuilderMethod, HTTPRequestBuilder {

        private var url: String!
        private var method: HTTPMethod!
        private var headers: [String: String]?
        private var queryItems: [String: String]?
        private var body: Data?
        private var pathParameters: [String]?
        private var acceptedStatusCode: Range<Int>?
        private var cachePolicy: URLRequest.CachePolicy?
        private var validator: RequestValidator?
        
        public func withURL(_ url: String) -> HTTPRequestBuilderMethod {
            self.url = url
            return self
        }
        
        public func withHTTPMethod(_ method: HTTPMethod) -> HTTPRequestBuilder {
            self.method = method
            return self
        }
        
        public func withHeaders(_ headers: [String: String]) -> HTTPRequestBuilder {
            self.headers = headers
            return self
        }
        
        public func withQueryItems(_ items: [String: String]) -> HTTPRequestBuilder {
            queryItems = items
            return self
        }
        
        public func withBody<T: Encodable>(_ body: T) -> HTTPRequestBuilder {
            self.body = encodeBody(body: body)
            return self
        }
        
        public func withPathParameters(_ parameters: [String]) -> HTTPRequestBuilder {
            pathParameters = parameters
            return self
        }
        
        public func withValidator(_ validator: RequestValidator) -> HTTPRequestBuilder {
            self.validator = validator
            return self
        }
        
        public func withCachePolicy(_ policy: URLRequest.CachePolicy) -> HTTPRequestBuilder {
            cachePolicy = policy
            return self
        }
        
        public func build() -> HTTPRequest {
            HTTPRequest(url: url,
                        method: method,
                        headers: headers ?? [:],
                        queryItems: queryItems ?? [:],
                        pathParameters: pathParameters ?? [],
                        validator: validator ?? .simple(acceptedStatusCode: 200..<300),
                        body: body,
                        cachePolicy: cachePolicy ?? .useProtocolCachePolicy)
        }
        
        func encodeBody<T: Encodable>(body: T) -> Data? {
            try? JSONEncoder().encode(body)
        }
        
    }

}
