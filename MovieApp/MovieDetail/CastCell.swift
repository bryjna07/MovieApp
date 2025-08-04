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
    
    var cast: Cast? {
        didSet {
            configureUIWithData()
        }
    }
    
    private let actorImageView = UIImageView()
    
    private let nameLabel = UILabel().then {
        $0.text = "text"
        $0.font = .systemFont(ofSize: 14)
        $0.textColor = .white
    }
    
    private let characterNameLabel = UILabel().then {
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
    
    override func configureUIWithData() {
        guard let cast else { return }
        nameLabel.text = cast.name
        characterNameLabel.text = cast.character
        guard let imageURL = cast.profilePath else { return }
        let urlString = MovieImage.movieImageURL(size: 200, posterPath: imageURL)
        let url = URL(string: urlString)
        actorImageView.setKFImage(from: url)
    }
    
    override func configureHierarchy() {
        [
            actorImageView,
            nameLabel,
            characterNameLabel,
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
        
        characterNameLabel.snp.makeConstraints {
            $0.leading.equalTo(nameLabel.snp.trailing).offset(4)
            $0.verticalEdges.equalToSuperview().inset(4)
            $0.trailing.lessThanOrEqualToSuperview().inset(8)
        }
    }
}
