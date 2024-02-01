//
//  MockResolver.swift
//  GithubSearchRepositoriesTests
//
//  Created by Dániel Novák on 01/02/2024.
//

@testable import GithubSearchRepositories

private let container = Container().withMockComponents()

func resolveMock<Service>(_ type: Service.Type) -> Service {
    container.resolve(type.self)!
}
