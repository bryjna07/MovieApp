//
//  RecentCell.swift
//  MovieApp
//
//  Created by YoungJin on 8/3/25.
//

import UIKit
import Then
import SnapKit

final class RecentCell: BaseCollectionViewCell {
    
    static let id = "RecentCell"
    
    private let nameLabel = UILabel().then {
        $0.text = "ㅇㅇㅇㅇ"
        $0.font = .systemFont(ofSize: 14)
        $0.textColor = .black
    }
    
    private let imageView = UIImageView().then {
        $0.image = UIImage(systemName: Text.SystemImage.xmark)
        $0.tintColor = .black
    }
}

extension RecentCell {
    override func configureHierarchy() {
        [
            nameLabel,
            imageView
        ].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func configureLayout() {
        nameLabel.snp.makeConstraints {
            $0.leading.verticalEdges.equalToSuperview().inset(8)
        }
        
        imageView.snp.makeConstraints {
            $0.leading.greaterThanOrEqualTo(nameLabel.snp.trailing).offset(8)
            $0.verticalEdges.trailing.equalToSuperview().inset(8)
        }
    }
    
    override func configureView() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 16
        contentView.clipsToBounds = true
    }
    
}
