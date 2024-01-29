//
//  Container+Data.swift
//  GithubSearchRepositories
//
//  Created by Dániel Novák on 28/01/2024.
//

extension Container {
    func withDataComponents() -> Self {
        register(ApiDataSource.self) { _ in
            ApiDataSourceImplementation()
        }
        return self
    }
}
