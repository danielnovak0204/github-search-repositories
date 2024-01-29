//
//  MockGithubRepositoriesViewModel.swift
//  GithubSearchRepositories
//
//  Created by Dániel Novák on 28/01/2024.
//

class MockGithubRepositoriesViewModel: GithubRepositoriesViewModelProtocol {
    var githubRepositories = mockGithubRepositories
    var errorMessage = ""
    var isFailed = false
    
    func search(_ searchTerm: String) async { }
}
