//
//  NumberFormatManager.swift
//  MovieApp
//
//  Created by YoungJin on 8/5/25.
//

import Foundation

struct NumberFormatManager {
    static let shared = NumberFormatManager()
    private init() {}
    
    private let formatter = NumberFormatter()
    
    func formatDouble(_ number: Double) -> String {
        formatter.maximumFractionDigits = 2
        let num = NSNumber(value: number)
        return formatter.string(from: num) ?? "\(number)"
    }
}
