//
//  ApiError.swift
//  GithubSearchRepositories
//
//  Created by Dániel Novák on 28/01/2024.
//

enum ApiError: Error {
    case configuration
    case decoding
    case noConnection
    case request
    case unknown
}
