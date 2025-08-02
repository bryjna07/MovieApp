//
//  CustomButton.swift
//  MovieApp
//
//  Created by YoungJin on 8/2/25.
//

import UIKit

final class CustomButton: UIButton {
    
    init(title: String) {
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        setTitleColor(.main, for: .normal)
        backgroundColor = .black
        layer.borderWidth = 1
        layer.borderColor = UIColor.main.cgColor
        layer.cornerRadius = 16
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
