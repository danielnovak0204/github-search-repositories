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
        ZStack {
            NavigationStack {
                List(viewModel.githubRepositories) { repository in
                    NavigationLink {
                        WebView(url: repository.htmlUrl)
                            .navigationBarTitleDisplayMode(.inline)
                            .navigationTitle(repository.name)
                            .ignoresSafeArea()
                    } label: {
                        GithubRepositoryView(entity: repository)
                    }
                }
                .listStyle(.plain)
                .navigationTitle("Repositories")
                .searchable(text: $viewModel.searchTerm)
                .onChange(of: viewModel.debouncedSearchTerm) { _, newValue in
                    search(newValue)
                }
                .alert("Error", isPresented: $viewModel.isFailed) {
                    Button("Retry") {
                        search(viewModel.debouncedSearchTerm)
                    }
                } message: {
                    Text(viewModel.errorMessage)
                }
            }
            
            if viewModel.isLoading {
                LoadingIndicatorView()
            }
        }
    }
    
    private func search(_ searchTerm: String) {
        Task {
            await viewModel.search(searchTerm)
        }
    }
}

#Preview {
    GithubRepositoriesView(viewModel: PreviewGithubRepositoriesViewModel())
}

#Preview {
    GithubRepositoriesView(viewModel: PreviewGithubRepositoriesViewModel())
        .preferredColorScheme(.dark)
}
