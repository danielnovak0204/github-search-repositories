//
//  Owner.swift
//  GithubSearchRepositories
//
//  Created by Dániel Novák on 28/01/2024.
//

struct Owner: Decodable {
    let login: String
    let avatarUrl: String
    
    private enum CodingKeys: String, CodingKey {
        case login
        case avatarUrl = "avatar_url"
    }
}
