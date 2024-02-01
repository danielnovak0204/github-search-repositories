//
//  Container+Data.swift
//  GithubSearchRepositories
//
//  Created by Dániel Novák on 28/01/2024.
//

extension Container {
    func withDataComponents() -> Self {
        register(RequestBuilder.self) { _ in
            RequestBuilderImplementation()
        }
        register(ApiDataSource.self) {
            ApiDataSourceImplementation(requestBuilder: $0.resolve(RequestBuilder.self)!)
        }
        return self
    }
}
