//
//  MovieAPI.swift
//  MovieApp
//
//  Created by YoungJin on 8/3/25.
//

import Foundation
import Alamofire

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
    
    var parameters: Parameters? {
        
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
            return nil
        case .credit:
            return [
                "language": "ko-KR"
            ]
        }
    }
}
