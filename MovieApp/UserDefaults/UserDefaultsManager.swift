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
    private let joinDateKey = "joinDate"
    private let recentArrayKey = "recentArray"
    private let likeKey = "like"
    
    //MARK: - 닉네임
    
    func getNickname() -> String? {
        let nickname = userDefaults.string(forKey: nicknameKey)
        return nickname
    }
    
    func saveNickname(_ nickname: String) {
        return userDefaults.set(nickname, forKey: nicknameKey)
    }
    
    //MARK: - 가입날짜
    func getJoinDate() -> String {
        guard let dateString = userDefaults.string(forKey: joinDateKey) else { return "" }
        return dateString
    }
    
    func saveJoinDate() {
        let date = Date()
        let dateString = DateFormatManager.shared.formatDate(date: date)
        return userDefaults.set(dateString, forKey: joinDateKey)
    }
    
    //MARK: - 최근 검색어
    
    func getRecent() -> [String]? {
        let recent = userDefaults.array(forKey: recentArrayKey) as? [String]
        return recent
    }
    
    func saveRecent(_ text: String) {
        if var array = getRecent() {
            guard !array.contains(text) else { return }
            array.insert(text, at: 0)
            return userDefaults.set(array, forKey: recentArrayKey)
        } else {
            let array = [text]
            return userDefaults.set(array, forKey: recentArrayKey)
        }
    }
    
    // 개별 삭제
    func deleteRecent(_ text: String) {
        guard var array = getRecent() else { return }
        if let index = array.firstIndex(of: text) {
            array.remove(at: index)
        }
        return userDefaults.set(array, forKey: recentArrayKey)
    }
    
    // 전체 삭제
    func allDeleteRecent() {
        guard getRecent() != nil else { return }
        return userDefaults.removeObject(forKey: recentArrayKey)
    }
    
    //MARK: - 좋아요
    
    func checkLiked(movieId: Int) -> Bool {
        guard let likeDict = userDefaults.dictionary(forKey: likeKey) as? [String: Bool] else { return false }
        return likeDict[String(movieId)] ?? false
    }
    
    func saveLiked(movieId: Int, isLiked: Bool) {
        // 기존 딕셔너리 꺼내와서 저장, 없으면 빈 딕셔너리로
        var likeDict = userDefaults.dictionary(forKey: likeKey) as? [String: Bool] ?? [:]
        likeDict[String(movieId)] = isLiked
        return userDefaults.set(likeDict, forKey: likeKey)
//        if var likeDict = userDefaults.dictionary(forKey: likeKey) as? [String: Bool] {
//            likeDict[String(movieId)] = isLiked
//            return userDefaults.set(likeDict, forKey: likeKey)
//        } else {
//            let likeDict = [String(movieId): isLiked]
//            return userDefaults.set(likeDict, forKey: likeKey)
//        }
    }
    
//    func deleteLiked(movieId: Int, isLiked: Bool) {
//        guard var likeDict = userDefaults.dictionary(forKey: likeKey) as? [String: Bool] else { return }
//        likeDict.removeValue(forKey: String(movieId))
//    }
    
    func getlikeCount() -> Int {
        guard let likeDict = userDefaults.dictionary(forKey: likeKey) as? [String: Bool] else { return 0 }
        let likeNum = likeDict.filter { $0.value == true }.count
        return likeNum
    }
}
