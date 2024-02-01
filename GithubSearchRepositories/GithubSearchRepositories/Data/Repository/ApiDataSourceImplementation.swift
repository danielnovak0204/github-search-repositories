//
//  ApiDataSourceImplementation.swift
//  GithubSearchRepositories
//
//  Created by Dániel Novák on 28/01/2024.
//

import Foundation

class ApiDataSourceImplementation: ApiDataSource {
    private enum Constants {
        static let apiBaseUrl = "https://api.github.com"
        static let searchRepositoriesUrlPath = "/search/repositories"
        static let sortQueryParameterValue = "stars"
        static let orderQueryParameterValue = "desc"
        static let perPageQueryParameterValue = "100"
        static let acceptHeaderParameterValue = "application/vnd.github+json"
        static let requestTimeout = 10.0
    }
    
    private let requestBuilder: RequestBuilder
    
    init(requestBuilder: RequestBuilder) {
        self.requestBuilder = requestBuilder
            .withHeaderParameter(key: .accept, value: Constants.acceptHeaderParameterValue)
            .withTimeout(Constants.requestTimeout)
    }
    
    func getSearchResults(searchTerm: String) async throws -> [GithubRepository] {
        let githubRepositoryWrapper: GithubRepositoryWrapper = try await requestBuilder
            .withType(.get)
            .withUrl(Constants.apiBaseUrl + Constants.searchRepositoriesUrlPath)
            .withQueryParameters([
                .query: searchTerm,
                .sort: Constants.sortQueryParameterValue,
                .order: Constants.orderQueryParameterValue,
                .perPage: Constants.perPageQueryParameterValue
            ])
            .request()
        return githubRepositoryWrapper.items
    }
}
