//
//  Container+Domain.swift
//  GithubSearchRepositories
//
//  Created by Dániel Novák on 28/01/2024.
//

extension Container {
    func withDomainComponents() -> Self {
        register(Repository.self) {
            RepositoryImplementation(apiDataSource: $0.resolve(ApiDataSource.self)!)
        }
        register(GetSearchResultsUseCase.self) {
            GetSearchResultsUseCaseImplementation(repository: $0.resolve(Repository.self)!)
        }
        return self
    }
}
