//
//  MovieAPI.swift
//  MovieApp
//
//  Created by YoungJin on 8/3/25.
//

import Foundation
import Alamofire

enum NetworkError: Error {
    case invalidURL
}

enum Router: URLRequestConvertible {
    case movie(MovieAPI)
    
    var method: HTTPMethod {
            switch self {
            case .movie(let api): return api.method
            }
        }
        
        var scheme: String {
            return "https"
        }
        
        var host: String {
            switch self {
            case .movie: return "api.themoviedb.org"
            }
        }
        
        var path: String {
            switch self {
            case .movie(let api): return api.path
            }
        }
        
        var parameters: Parameters {
            switch self {
            case .movie(let api): return api.parameters
            }
        }
        
        var headers: HTTPHeaders {
            switch self {
            case .movie(let api): return api.headers
            }
        }
        
        func asURLRequest() throws -> URLRequest {
            var components = URLComponents()
            components.scheme = scheme
            components.host = host
            components.path = path
            
            guard let url = components.url else {
                throw NetworkError.invalidURL
            }
            
            var request = URLRequest(url: url)
            request.method = method
            request.headers = headers
            
            return try URLEncoding.default.encode(request, with: parameters)
        }
}

enum MovieAPI {
    case trending(page: Int)
    case search(query: String, page: Int)
    case backdrop(id: Int)
    case credit(id: Int)
    
    var method: HTTPMethod {
            return .get
        }
    
    private var apiKey: String? {
            return Bundle.main.object(forInfoDictionaryKey: "APIKey") as? String
        }
    
    var headers: HTTPHeaders {
        guard let key = apiKey else {
            fatalError("API 키가 설정되지 않았습니다.")
        }
            return ["Authorization": "\(key)"]
        }
    
    var path: String {
        switch self {
        case .trending:
            return "/3/trending/movie/day"
        case .search:
            return "/3/search/movie"
        case .backdrop(let id):
            return "/3/movie/\(id)/images"
        case .credit(id: let id):
            return "/3/movie/\(id)/credits"
        }
    }
    
    var parameters: Parameters {
        
        switch self {
        case .trending(let page):
            return [
                "language": "ko-KR",
                "page": page
            ]
        case .search(let query, let page):
            return [
                "language": "ko-KR",
                "query": query,
                "page": page,
                "include_adult": false
            ]
        case .backdrop:
            return [:]
        case .credit:
            return [
                "language": "ko-KR"
            ]
        }
    }
}

enum MovieImage {
    
    static let imageBaseURL = "https://image.tmdb.org/t/p/"
    
    static func movieImageURL(size: Int, posterPath: String) -> String {
        return "\(imageBaseURL)w\(size)\(posterPath)"
    }
}
