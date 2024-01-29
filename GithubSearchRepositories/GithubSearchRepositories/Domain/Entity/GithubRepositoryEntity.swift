//
//  GithubRepositoryEntity.swift
//  GithubSearchRepositories
//
//  Created by Dániel Novák on 28/01/2024.
//

struct GithubRepositoryEntity: Identifiable {
    let id: Int
    let name: String
    let ownerName: String
    let avatarUrl: String
    let htmlUrl: String
    let description: String
    let starsCount: Int
    let language: String
}
