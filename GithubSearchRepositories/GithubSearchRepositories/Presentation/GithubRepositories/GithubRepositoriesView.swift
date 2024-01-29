//
//  GithubRepositoriesView.swift
//  GithubSearchRepositories
//
//  Created by Dániel Novák on 27/01/2024.
//

import SwiftUI

struct GithubRepositoriesView<ViewModel: GithubRepositoriesViewModelProtocol>: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        NavigationStack {
            List(viewModel.githubRepositories) { repository in
                NavigationLink {
                    WebView(urlString: repository.htmlUrl)
                        .navigationBarTitleDisplayMode(.inline)
                        .navigationTitle(repository.name)
                        .ignoresSafeArea()
                } label: {
                    GithubRepositoryView(entity: repository)
                }
            }
            .navigationTitle("Repositories")
            .listStyle(.plain)
        }
    }
}

#Preview {
    GithubRepositoriesView(viewModel: MockGithubRepositoriesViewModel())
}

#Preview {
    GithubRepositoriesView(viewModel: MockGithubRepositoriesViewModel())
        .preferredColorScheme(.dark)
}
