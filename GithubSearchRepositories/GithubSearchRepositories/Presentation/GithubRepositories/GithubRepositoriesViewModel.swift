//
//  GithubRepositoriesViewModel.swift
//  GithubSearchRepositories
//
//  Created by Dániel Novák on 28/01/2024.
//

import Foundation

protocol GithubRepositoriesViewModelProtocol: ObservableObject {
    var githubRepositories: [GithubRepositoryEntity] { get }
    var errorMessage: String { get }
    var isFailed: Bool { get set }
    
    func search(_ searchTerm: String) async
}

class GithubRepositoriesViewModel: GithubRepositoriesViewModelProtocol {
    private enum Constants {
        static let configurationErrorMessage = "Configuration error"
        static let decodingErrorMessage = "Decoding error"
        static let noConnectionErrorMessage = "No connection"
        static let requestErrorMessage = "Request failed"
        static let unknownErrorMessage = "Unknown error"
    }
    
    @Published private(set) var githubRepositories = [GithubRepositoryEntity]()
    @Published private(set) var errorMessage = ""
    @Published var isFailed = false
    private let getSearchResultsUseCase: GetSearchResultsUseCase
    
    init(getSearchResultsUseCase: GetSearchResultsUseCase) {
        self.getSearchResultsUseCase = getSearchResultsUseCase
    }
    
    func search(_ searchTerm: String) async {
        do {
            githubRepositories = try await getSearchResultsUseCase.getSearchResults(searchTerm: searchTerm)
        } catch {
            switch error {
            case ApiError.configuration: errorMessage = Constants.configurationErrorMessage
            case ApiError.decoding: errorMessage = Constants.decodingErrorMessage
            case ApiError.noConnection: errorMessage = Constants.noConnectionErrorMessage
            case ApiError.request: errorMessage = Constants.requestErrorMessage
            default: errorMessage = Constants.unknownErrorMessage
            }
            isFailed = true
        }
    }
}
