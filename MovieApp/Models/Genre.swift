//
//  Genre.swift
//  MovieApp
//
//  Created by YoungJin on 8/3/25.
//

import Foundation

enum Genre {
    static let list: [Int: String] = [
        28: "액션", 12: "모험", 37: "서부",
        16: "애니메이션", 35: "코미디", 53: "스릴러",
        80: "범죄", 99: "다큐멘터리", 10752: "전쟁",
        18: "드라마", 10751: "가족", 878: "SF",
        14: "판타지", 36: "역사", 10770: "TV 영화",
        27: "공포", 10402: "음악",
        9648: "미스터리", 10749: "로맨스",
    ]
    
    static func genreForString(id: Int) -> String {
        return list[id] ?? ""
    }
}
