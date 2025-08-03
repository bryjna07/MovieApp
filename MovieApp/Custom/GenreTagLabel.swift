//
//  GenreTagLabel.swift
//  MovieApp
//
//  Created by YoungJin on 8/4/25.
//

import UIKit

final class GenreTagLabel: UILabel {
    
    init(title: String) {
        super.init(frame: .zero)
        self.text = title
        self.font = .systemFont(ofSize: 14)
        self.backgroundColor = .darkGray
        self.textColor = .movieLightGray
        self.textAlignment = .center
        self.layer.cornerRadius = 4
        self.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

