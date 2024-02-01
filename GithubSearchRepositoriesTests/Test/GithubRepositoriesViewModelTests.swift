//
//  GithubRepositoriesViewModelTests.swift
//  GithubSearchRepositoriesTests
//
//  Created by Dániel Novák on 01/02/2024.
//

import Combine
import XCTest
@testable import GithubSearchRepositories

@MainActor
final class GithubRepositoriesViewModelTests: XCTestCase {
    private let viewModel = GithubRepositoriesViewModel(
        getSearchResultsUseCase: resolveMock(GetSearchResultsUseCase.self)
    )
    private var cancellables = Set<AnyCancellable>()
    
    func test_Given_Response_When_Search_Then_Loading_State_Changes() async {
        MockResponseProvider.provideMockResponse(statusCode: 200, json: "GetSearchResultsResponse")
        
        var isLoadingTrueCount = 0
        var isLoadingFalseCount = 0
        let expectation = expectation(description: "Loading should be indicated while searching")
        
        viewModel.$isLoading
            .dropFirst()
            .sink { isLoading in
                if isLoading {
                    isLoadingTrueCount += 1
                } else {
                    isLoadingFalseCount += 1
                }
                XCTAssertLessThanOrEqual(isLoadingTrueCount, 1)
                XCTAssertLessThanOrEqual(isLoadingFalseCount, 1)
                if isLoadingTrueCount == 1 && isLoadingFalseCount == 1 {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        await viewModel.search("tetris")
        await fulfillment(of: [expectation], timeout: 1)
    }
    
    func test_Given_Response_When_Search_Then_Items_State_Changes() async {
        MockResponseProvider.provideMockResponse(statusCode: 200, json: "GetSearchResultsResponse")
        
        let expectation = expectation(description: "Items should change")
        
        viewModel.$githubRepositories
            .dropFirst()
            .sink { _ in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        await viewModel.search("tetris")
        await fulfillment(of: [expectation], timeout: 1)
    }
    
    func test_Given_Failed_Response_When_Search_Then_Error_State_Changes() async throws {
        MockResponseProvider.provideMockResponse(statusCode: 422, json: "GetSearchResultsValidationFailedResponse")
        
        await viewModel.search("tetris")
        XCTAssert(viewModel.isFailed)
    }
    
    func test_Given_Failed_Response_When_Search_Then_Error_Message_State_Changes() async throws {
        MockResponseProvider.provideMockResponse(statusCode: 422, json: "GetSearchResultsValidationFailedResponse")
        
        await viewModel.search("tetris")
        XCTAssert(!viewModel.errorMessage.isEmpty)
    }
}
