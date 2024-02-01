//
//  RepositoryImplementation.swift
//  GithubSearchRepositories
//
//  Created by Dániel Novák on 28/01/2024.
//

class RepositoryImplementation: Repository {
    private let apiDataSource: ApiDataSource
    
    init(apiDataSource: ApiDataSource) {
        self.apiDataSource = apiDataSource
    }
    
    func getSearchResults(searchTerm: String) async throws -> [GithubRepositoryEntity] {
        let githubRepositories = try await apiDataSource.getSearchResults(searchTerm: searchTerm)
        return githubRepositories.map { githubRepository in
            GithubRepositoryEntity(
                id: githubRepository.id,
                name: githubRepository.name,
                ownerName: githubRepository.owner.login,
                avatarUrl: githubRepository.owner.avatarUrl,
                htmlUrl: githubRepository.htmlUrl,
                description: githubRepository.description ?? "",
                starsCount: githubRepository.stargazersCount,
                language: githubRepository.language ?? ""
            )
        }
    }
}
