//
//  RequestBuilderImplementation.swift
//  GithubSearchRepositories
//
//  Created by Dániel Novák on 31/01/2024.
//

import Foundation

class RequestBuilderImplementation: RequestBuilder {
    private let urlSession: URLSession
    private var url = ""
    private var type = HTTPMethod.get
    private var queryParameters = [QueryKey: String]()
    private var headerParameters = [HeaderKey: String]()
    
    private var urlRequest: URLRequest {
        get throws {
            guard !url.isEmpty, var urlComponents = URLComponents(string: url) else {
                throw ApiError.configuration
            }
            urlComponents.queryItems = queryParameters.map { key, value in
                URLQueryItem(name: key.rawValue, value: value)
            }
            guard let url = urlComponents.url else {
                throw ApiError.configuration
            }
            var request = URLRequest(url: url)
            request.httpMethod = type.rawValue
            headerParameters.forEach { key, value in
                request.setValue(value, forHTTPHeaderField: key.rawValue)
            }
            return request
        }
    }
    
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    func withUrl(_ url: String) -> Self {
        self.url = url
        return self
    }

    func withType(_ type: HTTPMethod) -> Self {
        self.type = type
        return self
    }

    func withTimeout(_ timeout: Double) -> Self {
        urlSession.configuration.timeoutIntervalForRequest = TimeInterval(timeout)
        return self
    }

    func withQueryParameter(key: QueryKey, value: String) -> Self {
        queryParameters[key] = value
        return self
    }

    func withQueryParameters(_ queryParameters: [QueryKey: String]) -> Self {
        self.queryParameters = queryParameters
        return self
    }

    func withHeaderParameter(key: HeaderKey, value: String) -> Self {
        headerParameters[key] = value
        return self
    }

    func withHeaderParameters(_ headerParameters: [HeaderKey: String]) -> Self {
        self.headerParameters = headerParameters
        return self
    }
    
    func request<T: Decodable>() async throws -> T {
        do {
            let (data, response) = try await urlSession.data(for: try urlRequest)
            try validateResponse(response)
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw error.asApiError
        }
    }
    
    private func validateResponse(_ response: URLResponse) throws {
        if (response as? HTTPURLResponse)?.statusCode == 200 {
            return
        }
        throw ApiError.request
    }
}

private extension Error {
    var asApiError: ApiError {
        if let apiError = self as? ApiError {
            return apiError
        } else if self is DecodingError {
            return ApiError.decoding
        } else if self.isNoConnection {
            return ApiError.noConnection
        } else {
            return ApiError.unknown
        }
    }
    
    private var isNoConnection: Bool {
        if let errorCode = (self as? URLError)?.errorCode {
            return errorCode == NSURLErrorNotConnectedToInternet || errorCode == NSURLErrorDataNotAllowed
        }
        return false
    }
}
