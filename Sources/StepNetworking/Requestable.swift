//
//  DataRequest.swift
//  Networking
//
//  Created by Marco Del Giudice on 02/12/21.
//

import Foundation

public struct Empty: Decodable {}

protocol Requestable {
    
    var url: String { get set}
    var method: HTTPMethod { get set }
    var headers: HTTPHeaders { get set }
    var queryItems: [String: String] { get set}
    var pathParameters: [String] { get set }
    var body: Data? { get set}
    var cachePolicy: URLRequest.CachePolicy { get set }
    var validator: RequestValidator { get set }
    
    func getURLRequest() throws -> URLRequest
}

extension Requestable {
    
    func getURLQueryItems() -> [URLQueryItem] {
        
        var queryItems: [URLQueryItem] = []
        self.queryItems.forEach {
            let urlQueryItem = URLQueryItem(name: $0.key, value: $0.value)
            queryItems.append(urlQueryItem)
        }
        return queryItems
    }
    
    func getURLRequest() throws -> URLRequest {
        
        guard var urlComponent = URLComponents(string: url) else {
            throw RequestError.invalidURL
        }
        
        urlComponent.queryItems = getURLQueryItems()
        
        guard var url = urlComponent.url else {
            throw RequestError.invalidURL
        }
        
        pathParameters.forEach({url.appendPathComponent($0)})
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = headers.getHTTPHeaders()
        
        if method != .get {
            urlRequest.httpBody = body
        }
        
        urlRequest.cachePolicy = cachePolicy
        
        return urlRequest
    }
    
}
