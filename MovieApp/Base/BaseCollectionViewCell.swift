//
//  BaseCollectionViewCell.swift
//  MovieApp
//
//  Created by YoungJin on 8/2/25.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BaseCollectionViewCell: ConfigureUI {
    
    func configureUIWithData() { }
    
    func configureHierarchy() { }
    
    func configureLayout() { }
    
    func configureView() { }
}
