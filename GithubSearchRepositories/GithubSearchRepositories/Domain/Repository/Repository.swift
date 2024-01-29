//
//  Repository.swift
//  GithubSearchRepositories
//
//  Created by Dániel Novák on 28/01/2024.
//

protocol Repository {
    func getSearchResults(searchTerm: String) async throws -> [GithubRepositoryEntity]
}
