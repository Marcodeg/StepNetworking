//
//  RequestableTests.swift
//  
//
//  Created by Marco Del Giudice on 02/03/22.
//

import XCTest
import Foundation
@testable import StepNetworking

class RequestableTests: XCTestCase {
    
    
    func test_getURLRequest() throws {
        let request = HTTPRequest.builder
            .withURL("url")
            .withHTTPMethod(.post)
            .withCachePolicy(.reloadIgnoringLocalAndRemoteCacheData)
            .withBody(FailureResponse(string: "S", name: "Elon"))
            .withHeaders([.acceptEncoding:"test"])
            .withPathParameters(["test", "testing"])
            .withQueryItems(["test":"testing"])
            .withValidator(.base(acceptedStatusCode: 200..<300))
            .build()
        
        let urlRequest = try? request.getURLRequest()
        
        XCTAssertNotNil(urlRequest)
        XCTAssertEqual(urlRequest?.url, URL(string: "url/test/testing?test=testing"))
        let body = FailureResponse(string: "S", name: "Elon").encode()
        XCTAssertEqual(urlRequest?.httpBody, body)
        XCTAssertEqual(urlRequest?.cachePolicy, URLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData)
        
    }

}
