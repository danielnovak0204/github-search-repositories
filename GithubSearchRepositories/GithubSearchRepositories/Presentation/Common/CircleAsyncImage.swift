//
//  CircleAsyncImage.swift
//  GithubSearchRepositories
//
//  Created by Dániel Novák on 29/01/2024.
//

import SwiftUI

struct CircleAsyncImage: View {
    let urlString: String
    
    var body: some View {
        AsyncImage(url: URL(string: urlString)) { image in
            image
                .resizable()
                .scaledToFit()
        } placeholder: {
            Color.gray
                .opacity(0.5)
        }
        .clipShape(Circle())
    }
}

#Preview {
    CircleAsyncImage(urlString: mockGithubRepositories.first!.avatarUrl)
}
