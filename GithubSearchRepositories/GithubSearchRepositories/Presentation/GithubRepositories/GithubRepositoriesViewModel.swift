//
//  GithubRepositoriesViewModel.swift
//  GithubSearchRepositories
//
//  Created by Dániel Novák on 28/01/2024.
//

import Combine
import Foundation

protocol GithubRepositoriesViewModelProtocol: ObservableObject {
    nonisolated var isFailed: Bool { get set }
    nonisolated var searchTerm: String { get set }
    nonisolated var debouncedSearchTerm: String { get }
    nonisolated var githubRepositories: [GithubRepositoryEntity] { get }
    nonisolated var errorMessage: String { get }
    nonisolated var isLoading: Bool { get }
    
    func search(_ searchTerm: String) async
}

@MainActor
class GithubRepositoriesViewModel: GithubRepositoriesViewModelProtocol {
    private enum Constants {
        static let configurationErrorMessage = "Configuration error"
        static let decodingErrorMessage = "Decoding error"
        static let noConnectionErrorMessage = "No connection"
        static let requestErrorMessage = "Request failed"
        static let unknownErrorMessage = "Unknown error"
    }
    
    @Published var isFailed = false
    @Published var searchTerm = ""
    @Published private(set) var debouncedSearchTerm = ""
    @Published private(set) var githubRepositories = [GithubRepositoryEntity]()
    @Published private(set) var errorMessage = ""
    @Published private(set) var isLoading = false
    private let getSearchResultsUseCase: GetSearchResultsUseCase
    
    init(getSearchResultsUseCase: GetSearchResultsUseCase) {
        self.getSearchResultsUseCase = getSearchResultsUseCase
        $searchTerm
            .removeDuplicates()
            .debounce(for: .seconds(1), scheduler: RunLoop.main)
            .assign(to: &$debouncedSearchTerm)
    }
    
    func search(_ searchTerm: String) async {
        isLoading = true
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
        isLoading = false
    }
}
