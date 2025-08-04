//
//  UserDefaultsManager.swift
//  MovieApp
//
//  Created by YoungJin on 8/4/25.
//

import Foundation

final class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    private let userDefaults = UserDefaults.standard
    private init() { }
    
    // 유저디폴트 키
    private let nicknameKey = "nickname"
    private let likeKey = "like"
    
    func getNickname() -> String? {
        let nickname = userDefaults.string(forKey: nicknameKey)
        return nickname
    }
    
    func saveNickname(_ nickname: String) {
        return userDefaults.set(nickname, forKey: nicknameKey)
    }
    
    func checkLiked(movieId: Int) -> Bool {
        guard let likeDict = userDefaults.dictionary(forKey: likeKey) as? [String: Bool] else { return false }
        return likeDict[String(movieId)] ?? false
    }
    
    func saveLiked(movieId: Int, isLiked: Bool) {
        // 기존 딕셔너리 꺼내와서 저장, 없으면 빈 딕셔너리로
        var likeDict = userDefaults.dictionary(forKey: likeKey) as? [String: Bool] ?? [:]
        likeDict[String(movieId)] = isLiked
        return userDefaults.set(likeDict, forKey: likeKey)
    }
}
