//
//  GithubRepositoryView.swift
//  GithubSearchRepositories
//
//  Created by Dániel Novák on 29/01/2024.
//

import SwiftUI

struct GithubRepositoryView: View {
    let entity: GithubRepositoryEntity
    
    var body: some View {
        HStack(alignment: .top, spacing: 15) {
            CircleAsyncImage(url: entity.avatarUrl)
                .frame(width: 50)
            VStack(alignment: .leading) {
                Text(entity.name)
                    .font(.headline)
                Text(entity.language)
                    .font(.subheadline)
                    .opacity(0.6)
                Text(entity.description)
                HStack {
                    HStack(spacing: 5) {
                        Image(systemName: "star.fill")
                        Text(String(entity.starsCount))
                    }
                    Divider()
                        .frame(height: 20)
                        .overlay(.primary)
                    Text(entity.ownerName)
                }
                .font(.subheadline)
            }
        }
    }
}

#Preview {
    GithubRepositoryView(entity: previewGithubRepositories.first!)
}
