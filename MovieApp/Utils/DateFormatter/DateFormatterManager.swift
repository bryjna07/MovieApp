//
//  DateFormatManager.swift
//  MovieApp
//
//  Created by YoungJin on 8/5/25.
//

import UIKit

struct DateFormatManager {
    static let shared = DateFormatManager()
    private init() {}
    
    private let formatter = DateFormatter()
    
    func formatDateString(dateString: String) -> String {
        formatter.dateFormat = "yyyy-MM-dd"
        if let date = formatter.date(from: dateString) {
            formatter.dateFormat = "yyyy.MM.dd"
            return formatter.string(from: date)
        } else {
            return ""
        }
    }
    
    func formatDate(date: Date) -> String {
        formatter.dateFormat = "yy.MM.dd"
        return formatter.string(from: date)
    }
}
