//
//  MovieAPI.swift
//  MovieApp
//
//  Created by YoungJin on 8/3/25.
//

import Foundation

enum MovieAPI {
    
    static let apiKey: String = {
        guard let key = Bundle.main.object(forInfoDictionaryKey: "APIKey") as? String else {
            fatalError("API 키가 설정되지 않았습니다.")
        }
        return key
    }()
    
    static let scheme = "https"
    
    static let host = "api.themoviedb.org"
    
    enum Path: String {
        case trending = "/3/trending/movie/day"
        case search = "/3/search/movie"
    }
    
    static let queryItems = [
        URLQueryItem(name: "language", value: "ko-KR"),
        URLQueryItem(name: "page", value: "1"),
    ]
}

struct MovieImage {
//    static let imageBaseURL = "https://api.themoviedb.org/3/movie/{movieID}/images"
    static func backdropURL(id: Int) -> String {
        return "https://api.themoviedb.org/3/movie/\(id)/images"
    }
    
    static let imageBaseURL = "https://image.tmdb.org/t/p/"
    
    static func movieImageURL(size: Int, posterPath: String) -> String {
        return "\(imageBaseURL)w\(size)\(posterPath)"
    }
}
