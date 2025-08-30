//
//  MovieImageAPI.swift
//  MovieApp
//
//  Created by YoungJin on 8/30/25.
//

import Foundation

enum MovieImageAPI {
    
    static let imageBaseURL = "https://image.tmdb.org/t/p/"
    
    static func movieImageURL(size: Int, posterPath: String) -> String {
        return "\(imageBaseURL)w\(size)\(posterPath)"
    }
}
