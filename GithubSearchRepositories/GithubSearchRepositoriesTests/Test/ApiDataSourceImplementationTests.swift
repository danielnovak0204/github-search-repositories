//
//  ApiDataSourceImplementationTests.swift
//  GithubSearchRepositoriesTests
//
//  Created by Dániel Novák on 31/01/2024.
//

import XCTest
@testable import GithubSearchRepositories

final class ApiDataSourceImplementationTests: XCTestCase {
    private let apiDataSource = resolveMock(ApiDataSource.self)
    
    func test_Given_Response_When_Get_Search_Results_Then_Returns_Items() async throws {
        MockResponseProvider.provideMockResponse(statusCode: 200, json: "GetSearchResultsResponse")
        
        _ = try await apiDataSource.getSearchResults(searchTerm: "tetris")
        XCTAssert(true)
    }
    
    func test_Given_Failed_Response_When_Request_Then_Throws_Request_Error() async throws {
        MockResponseProvider.provideMockResponse(statusCode: 422, json: "GetSearchResultsValidationFailedResponse")
        
        do {
            _ = try await apiDataSource.getSearchResults(searchTerm: "tetris")
            XCTAssert(false)
        } catch ApiError.request {
            XCTAssert(true)
        } catch {
            XCTAssert(false)
        }
    }
}
