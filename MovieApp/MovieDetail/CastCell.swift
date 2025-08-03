//
//  CastCell.swift
//  MovieApp
//
//  Created by YoungJin on 8/4/25.
//

import UIKit
import Then
import SnapKit

final class CastCell: BaseTableViewCell {
    
    static let id = "CastCell"
    
    private let actorImageView = UIImageView().then {
        $0.backgroundColor = .main
    }
    
    private let nameLabel = UILabel().then {
        $0.text = "text"
        $0.font = .systemFont(ofSize: 14)
        $0.textColor = .white
    }
    
    private let englishNameLabel = UILabel().then {
        $0.text = "text"
        $0.font = .systemFont(ofSize: 14)
        $0.textColor = .movieLightGray
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        actorImageView.layer.cornerRadius = actorImageView.bounds.width / 2
        actorImageView.clipsToBounds = true
    }
}

extension CastCell {
    override func configureHierarchy() {
        [
            actorImageView,
            nameLabel,
            englishNameLabel,
        ].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func configureLayout() {
        actorImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(8)
            $0.top.greaterThanOrEqualToSuperview().inset(4)
            $0.bottom.lessThanOrEqualToSuperview().inset(4)
            $0.size.equalTo(40)
        }
        
        nameLabel.snp.makeConstraints {
            $0.leading.equalTo(actorImageView.snp.trailing).offset(4)
            $0.verticalEdges.equalToSuperview().inset(4)
        }
        
        englishNameLabel.snp.makeConstraints {
            $0.leading.equalTo(nameLabel.snp.trailing).offset(4)
            $0.verticalEdges.equalToSuperview().inset(4)
            $0.trailing.lessThanOrEqualToSuperview().inset(8)
        }
    }
}
