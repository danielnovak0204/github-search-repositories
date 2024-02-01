//
//  Container+Mock.swift
//  GithubSearchRepositoriesTests
//
//  Created by Dániel Novák on 01/02/2024.
//

import Foundation
@testable import GithubSearchRepositories

extension Container {
    func withMockComponents() -> Self {
        register(RequestBuilder.self) { _ in
            let urlSessionConfig = URLSessionConfiguration.ephemeral
            urlSessionConfig.protocolClasses = [MockURLProtocol.self]
            let urlSession = URLSession(configuration: urlSessionConfig)
            return RequestBuilderImplementation(urlSession: urlSession)
        }
        register(ApiDataSource.self) {
            ApiDataSourceImplementation(requestBuilder: $0.resolve(RequestBuilder.self)!)
        }
        register(Repository.self) {
            RepositoryImplementation(apiDataSource: $0.resolve(ApiDataSource.self)!)
        }
        register(GetSearchResultsUseCase.self) {
            GetSearchResultsUseCaseImplementation(repository: $0.resolve(Repository.self)!)
        }
        return self
    }
}
