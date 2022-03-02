//
//  HTTPRequestBuilderTests.swift
//  
//
//  Created by Marco Del Giudice on 02/03/22.
//

import XCTest
import Foundation
@testable import StepNetworking

class HTTPRequestBuilderTests: XCTestCase {
    
    struct FailureResponse: Codable {
        var string: String
        var name: String
    }

    func testBuilder() throws {
        let request = HTTPRequest.builder
            .withURL("url")
            .withHTTPMethod(.get)
            .withCachePolicy(.reloadIgnoringLocalAndRemoteCacheData)
            .withBody(FailureResponse(string: "S", name: "Elon"))
            .withHeaders([.acceptEncoding:"test"])
            .withPathParameters(["test", "testing"])
            .withQueryItems(["test":"testing"])
            .withValidator(.base(acceptedStatusCode: 200..<300))
            .build()
        
        XCTAssertEqual(request.url, "url")
        XCTAssertEqual(request.method, HTTPMethod.get)
        XCTAssertEqual(request.cachePolicy, URLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData)
        XCTAssertEqual(request.body, FailureResponse(string: "S", name: "Elon").encode())
        XCTAssertEqual(request.headers, [.acceptEncoding:"test"])
        XCTAssertEqual(request.pathParameters, ["test", "testing"])
        XCTAssertEqual(request.queryItems, ["test":"testing"])
        XCTAssertEqual(request.validator, RequestValidator.base(acceptedStatusCode: 200..<300))
    }
    
    func testBuilder_withDefaultValue() throws {
        let request = HTTPRequest.builder
            .withURL("url")
            .withHTTPMethod(.get)
            .build()
        
        XCTAssertEqual(request.url, "url")
        XCTAssertEqual(request.method, HTTPMethod.get)
        XCTAssertEqual(request.cachePolicy, URLRequest.CachePolicy.useProtocolCachePolicy)
        XCTAssertEqual(request.body, nil)
        XCTAssertEqual(request.headers, [:])
        XCTAssertEqual(request.pathParameters, [])
        XCTAssertEqual(request.queryItems, [:])
        XCTAssertEqual(request.validator, RequestValidator.base(acceptedStatusCode: 200..<300))
    }
}
