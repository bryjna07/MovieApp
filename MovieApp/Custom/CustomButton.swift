//
//  CustomButton.swift
//  MovieApp
//
//  Created by YoungJin on 8/2/25.
//

import UIKit

final class CustomButton: UIButton {
    
    init(title: String, color: UIColor, width: CGFloat) {
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        setTitleColor(color, for: .normal)
        backgroundColor = .black
        layer.borderWidth = width
        layer.borderColor = color.cgColor
        layer.cornerRadius = 20
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
