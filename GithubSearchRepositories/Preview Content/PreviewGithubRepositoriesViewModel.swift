//
//  PreviewGithubRepositoriesViewModel.swift
//  GithubSearchRepositories
//
//  Created by Dániel Novák on 28/01/2024.
//

class PreviewGithubRepositoriesViewModel: GithubRepositoriesViewModelProtocol {
    var githubRepositories = previewGithubRepositories
    var errorMessage = ""
    var isFailed = false
    var searchTerm = ""
    var debouncedSearchTerm = ""
    var isLoading = false
    
    func search(_ searchTerm: String) async { }
}
