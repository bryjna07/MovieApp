//
//  Router.swift
//  MovieApp
//
//  Created by YoungJin on 8/30/25.
//

import Foundation
import Alamofire

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
    
    var parameters: Parameters? {
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
