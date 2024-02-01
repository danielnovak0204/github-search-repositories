//
//  MockResponseProvider.swift
//  GithubSearchRepositoriesTests
//
//  Created by Dániel Novák on 30/01/2024.
//

import Foundation
import XCTest
@testable import GithubSearchRepositories

class MockResponseProvider {
    static func provideMockResponse(statusCode: Int, json resource: String) {
        guard let jsonPath = Bundle(for: Self.self).path(forResource: resource, ofType: "json") else {
            XCTFail("MockResponseProvider: failed to get json resource path")
            return
        }
        guard let jsonData = try? String(contentsOfFile: jsonPath).data(using: .utf8) else {
            XCTFail("MockResponseProvider: failed to get data from json resource")
            return
        }
        MockURLProtocol.responseProvider = { request in
            guard let url = request.url, let response = HTTPURLResponse(
                url: url,
                statusCode: statusCode,
                httpVersion: nil,
                headerFields: nil
            ) else {
                XCTFail("MockResponseProvider: failed to provide mock response")
                throw ApiError.unknown
            }
            return (response, jsonData)
        }
    }
}
