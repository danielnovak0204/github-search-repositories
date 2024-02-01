//
//  RequestBuilderImplementationTests.swift
//  GithubSearchRepositoriesTests
//
//  Created by Dániel Novák on 27/01/2024.
//

import XCTest
@testable import GithubSearchRepositories

final class RequestBuilderImplementationTests: XCTestCase {
    private let requestBuilder = resolveMock(RequestBuilder.self)

    func test_Given_Parameters_When_Request_Then_Returns_Items() async throws {
        MockResponseProvider.provideMockResponse(statusCode: 200, json: "GetSearchResultsResponse")
        
        let _: GithubRepositoryWrapper = try await requestBuilder
            .withType(.get)
            .withUrl("https://api.github.com/search/repositories")
            .withHeaderParameter(key: .accept, value: "application/vnd.github+json")
            .withQueryParameters([.query: "tetris"])
            .withTimeout(10)
            .request()
        XCTAssert(true)
    }
    
    func test_Given_Empty_Url_When_Request_Then_Throws_Configuration_Error() async throws {
        do {
            let _: GithubRepositoryWrapper = try await requestBuilder
                .withType(.get)
                .withUrl("")
                .withHeaderParameter(key: .accept, value: "application/vnd.github+json")
                .withQueryParameters([.query: "tetris"])
                .withTimeout(10)
                .request()
            XCTAssert(false)
        } catch ApiError.configuration {
            XCTAssert(true)
        } catch {
            XCTAssert(false)
        }
    }
    
    func test_Given_Failed_Response_When_Request_Then_Throws_Request_Error() async throws {
        MockResponseProvider.provideMockResponse(statusCode: 422, json: "GetSearchResultsValidationFailedResponse")
        
        do {
            let _: GithubRepositoryWrapper = try await requestBuilder
                .withType(.get)
                .withUrl("https://api.github.com/search/repositories")
                .withHeaderParameter(key: .accept, value: "application/vnd.github+json")
                .withQueryParameters([.query: ""])
                .withTimeout(10)
                .request()
            XCTAssert(false)
        } catch ApiError.request {
            XCTAssert(true)
        } catch {
            XCTAssert(false)
        }
    }
    
    func test_Given_Incorrect_Response_When_Request_Then_Throws_Decoding_Error() async throws {
        MockResponseProvider.provideMockResponse(statusCode: 200, json: "GetSearchResultsIncorrectResponse")
        
        do {
            let _: GithubRepositoryWrapper = try await requestBuilder
                .withType(.get)
                .withUrl("https://api.github.com/search/repositories")
                .withHeaderParameters([.accept: "application/vnd.github+json"])
                .withQueryParameter(key: .query, value: "tetris")
                .withTimeout(10)
                .request()
            XCTAssert(false)
        } catch ApiError.decoding {
            XCTAssert(true)
        } catch {
            XCTAssert(false)
        }
    }
}
