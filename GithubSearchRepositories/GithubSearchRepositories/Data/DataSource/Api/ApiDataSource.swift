//
//  ApiDataSource.swift
//  GithubSearchRepositories
//
//  Created by Dániel Novák on 28/01/2024.
//

protocol ApiDataSource {
    func getSearchResults(searchTerm: String) async throws -> [GithubRepository]
}
