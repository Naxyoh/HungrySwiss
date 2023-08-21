//
//  URLSessionHTTPProvider.swift
//  HungrySwiss
//
//  Created by Yoan Smit on 17/08/2023.
//

import Foundation

struct URLSessionHTTPProvider {
    
    enum Error: Swift.Error {
        case invalidBaseURL
        case componentsBuildFailed
        case urlBuildingFailed
    }
    
    // MARK: - Private Properties
    
    private let baseURL: String
    private let urlSession: URLSession
    
    // MARK: - Initialization Methods
    
    init(baseURL: String, urlSession: URLSession) {
        self.baseURL = baseURL
        self.urlSession = urlSession
    }
    
    // MARK: - Private Methods
    
    private func makeURLRequest(from request: HTTPRequest) throws -> URLRequest {
        guard let baseURL = URL(string: baseURL) else {
            throw Error.invalidBaseURL
        }
        
        guard var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: false) else {
            throw Error.componentsBuildFailed
        }
        
        components.path += request.path
        
        if request.queryParameters.isEmpty {
            components.queryItems = nil
        } else {
            components.queryItems = request
                .queryParameters
                .map { URLQueryItem(name: $0, value: $1) }
        }

        guard let finalUrl = components.url else {
            throw Error.urlBuildingFailed
        }

        var urlRequest = URLRequest(url: finalUrl)
        urlRequest.httpMethod = request.method.rawValue

        return urlRequest
    }
    
}

extension URLSessionHTTPProvider: HTTPProvider {
    
    func send(_ request: HTTPRequest) async throws -> HTTPResponse {
        let urlRequest = try makeURLRequest(from: request)
        
        let (data, _) = try await urlSession.data(for: urlRequest)
        
        return HTTPResponse(body: data)
    }
    
}
