//
//  Movie.swift
//  MovieApp
//
//  Created by YoungJin on 8/3/25.
//

import Foundation

struct MovieInfo: Codable {
    let page: Int
    let results: [Movie]
    let totalPages, totalResults: Int?
    
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct Movie: Codable {
    let id: Int
    let backdropPath: String?
    let title: String
    let overview: String?   // 빈값 주의
    let posterPath: String?
    let genreIds: [Int]
    let releaseDate: String
    let voteAverage: Double
    
    enum CodingKeys: String, CodingKey {
        case id
        case backdropPath = "backdrop_path"
        case title
        case overview
        case posterPath = "poster_path"
        case genreIds = "genre_ids"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
    }
    
    var formattedReleaseDate: String {
        return DateFormatManager.shared.formatDateString(dateString: releaseDate)
    }
    
    var transformGenreArray: [String] {
        let intArray = Array(genreIds.prefix(2))
        let stringArray = intArray.map {
            Genre.genreForString(id: $0)
        }
        return stringArray
    }
    
    var transformAverage: String {
        return NumberFormatManager.shared.formatDouble(voteAverage)
    }
}

// MARK: - Backdrop

struct BackdropInfo: Codable {
    let id: Int
    let backdrops: [Backdrop]
}

struct Backdrop: Codable {
    let filePath: String
    
    enum CodingKeys: String, CodingKey {
        case filePath = "file_path"
    }
}

// MARK: - Cast

struct CastInfo: Codable {
    let id: Int        // 영화 ID
    let cast: [Cast]
}

struct Cast: Codable {
    let name: String          // 배우 이름
    let profilePath: String?  // 배우 이미지
    let character: String?    // 영화 캐릭터 이름

    enum CodingKeys: String, CodingKey {
        case name
        case profilePath = "profile_path"
        case character
    }
}
