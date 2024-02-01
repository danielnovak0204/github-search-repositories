//
//  GetSearchResultsUseCase.swift
//  GithubSearchRepositories
//
//  Created by Dániel Novák on 28/01/2024.
//

protocol GetSearchResultsUseCase {
    func getSearchResults(searchTerm: String) async throws -> [GithubRepositoryEntity]
}

class GetSearchResultsUseCaseImplementation: GetSearchResultsUseCase {
    private let repository: Repository
    
    init(repository: Repository) {
        self.repository = repository
    }
    
    func getSearchResults(searchTerm: String) async throws -> [GithubRepositoryEntity] {
        if searchTerm.isEmpty {
            return []
        }
        return try await repository.getSearchResults(searchTerm: searchTerm)
    }
}
