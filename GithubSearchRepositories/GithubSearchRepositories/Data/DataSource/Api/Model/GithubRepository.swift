//
//  GithubRepository.swift
//  GithubSearchRepositories
//
//  Created by Dániel Novák on 28/01/2024.
//

struct GithubRepository: Decodable {
    let id: Int
    let name: String
    let owner: Owner
    let htmlUrl: String
    let description: String?
    let stargazersCount: Int
    let language: String?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case owner
        case htmlUrl = "html_url"
        case description
        case stargazersCount = "stargazers_count"
        case language
    }
}
