//
//  RequestBuilder.swift
//  GithubSearchRepositories
//
//  Created by Dániel Novák on 31/01/2024.
//

protocol RequestBuilder {
    func withUrl(_ url: String) -> Self
    func withType(_ type: HTTPMethod) -> Self
    func withTimeout(_ timeout: Double) -> Self
    func withQueryParameter(key: QueryKey, value: String) -> Self
    func withQueryParameters(_ queryParameters: [QueryKey: String]) -> Self
    func withHeaderParameter(key: HeaderKey, value: String) -> Self
    func withHeaderParameters(_ headerParameters: [HeaderKey: String]) -> Self
    func request<T: Decodable>() async throws -> T
}

enum HTTPMethod: String {
    case get = "GET"
}

enum QueryKey: String {
    case query = "q"
    case sort
    case order
    case perPage = "per_page"
}

enum HeaderKey: String {
    case accept
}
