//
//  ValidatorTests.swift
//  
//
//  Created by Marco Del Giudice on 01/03/22.
//

import XCTest
@testable import StepNetworking

class ValidatorTests: XCTestCase {
    
    struct FailureResponse: Codable {
        var string: String
        var name: String
    }
    
    func test_simpleValidator_shouldSuccess() {
        let response = HTTPURLResponse(url: URL(fileURLWithPath: ""), statusCode: 202, httpVersion: nil, headerFields: nil)
        XCTAssertNotNil(response)
        do {
            try RequestValidator.base(acceptedStatusCode: 200..<220).validator.validate(response: response!)
        } catch {
            XCTFail("\(error)")
        }
    }
    
    func test_simpleValidator_shouldFail_withDeniedStatusCode() {
        let response = HTTPURLResponse(url: URL(fileURLWithPath: ""), statusCode: 222, httpVersion: nil, headerFields: nil)
        XCTAssertNotNil(response)
        do {
            try RequestValidator.base(acceptedStatusCode: 200..<220)
                .validator
                .validate(response: response!)
            XCTFail()
        } catch let validatingError as ValidatingError {
            switch validatingError {
            case .unexpectedResponse:
                XCTFail()
            case .deneiedStatusCode(code: let code):
                XCTAssert(code == 222)
            case .requestError(failureResponse: _, code: _):
                XCTFail()
            }
        } catch {
            XCTFail()
        }
    }
    
    func test_simpleValidator_withFailureResponse_shouldSuccess() {
        let response = HTTPURLResponse(url: URL(fileURLWithPath: ""), statusCode: 200, httpVersion: nil, headerFields: nil)
        XCTAssertNotNil(response)
        let failureResponse = FailureResponse(string: "axy", name: "Elon")
        let data = try? JSONEncoder().encode(failureResponse)
        XCTAssertNotNil(data)
        
        do {
            try RequestValidator.base(acceptedStatusCode: 200..<220)
                .validator
                .validate(response: response!, data: data!, failureResponse: FailureResponse.self)
        } catch {
            XCTFail("\(error)")
        }

    }
    
    func test_simpleValidator_withFailureResponse_shouldFail() {
        let response = HTTPURLResponse(url: URL(fileURLWithPath: ""), statusCode: 404, httpVersion: nil, headerFields: nil)
        XCTAssertNotNil(response)
        let failureResponse = FailureResponse(string: "axy", name: "Elon")
        let data = try? JSONEncoder().encode(failureResponse)
        XCTAssertNotNil(data)
        
        do {
            try RequestValidator.base(acceptedStatusCode: 200..<220)
                .validator
                .validate(response: response!, data: data!, failureResponse: FailureResponse.self)
            XCTFail()
        } catch let validatingError as ValidatingError {
            switch validatingError {
            case .unexpectedResponse:
                XCTFail()
            case .deneiedStatusCode(code: _):
                XCTFail()
            case .requestError(failureResponse: let failureResponse, code: let code):
                XCTAssertNotNil(failureResponse)
                XCTAssert(code == 404)
            }
        } catch {
            XCTFail()
        }

    }
    
}
