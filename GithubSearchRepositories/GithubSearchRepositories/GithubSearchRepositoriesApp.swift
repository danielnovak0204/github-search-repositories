//
//  GithubSearchRepositoriesApp.swift
//  GithubSearchRepositories
//
//  Created by Dániel Novák on 27/01/2024.
//

import SwiftUI

@main
struct GithubSearchRepositoriesApp: App {
    private let getSearchResultsUseCase = Resolver.shared.resolve(GetSearchResultsUseCase.self)
    
    var body: some Scene {
        WindowGroup {
            GithubRepositoriesView(
                viewModel: GithubRepositoriesViewModel(getSearchResultsUseCase: getSearchResultsUseCase)
            )
        }
    }
}
