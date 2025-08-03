//
//  TodayMovieCell.swift
//  MovieApp
//
//  Created by YoungJin on 8/3/25.
//

import UIKit
import Then
import SnapKit

final class TodayMovieCell: BaseCollectionViewCell {
    
    static let id = "TodayMovieCell"
    
    var movie: Movie? {
        didSet {
            configureUIWithData()
        }
    }
    
    private let imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
    }
    
    private let nameLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16)
        $0.textColor = .white
    }
    
    private let explainLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 12)
        $0.textColor = .movieGray
        $0.numberOfLines = 3
    }
}

extension TodayMovieCell {
    
    override func configureUIWithData() {
        guard let movie else { return }
        nameLabel.text = movie.title
        if movie.overview == "" {
            explainLabel.text = "정보 없음"
        } else {
            explainLabel.text = movie.overview
        }
        guard let imageURL = movie.posterPath else { return }
        let urlString = MovieImage.movieImageURL(size: 200, posterPath: imageURL)
        let url = URL(string: urlString)
        imageView.setKFImage(from: url)
    }
    
    override func configureHierarchy() {
        [
            imageView,
            nameLabel,
            explainLabel,
        ].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func configureLayout() {
        
        imageView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(self.bounds.width * 1.5)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(8)
            $0.horizontalEdges.equalToSuperview()
        }
        
        explainLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(8)
            $0.horizontalEdges.equalToSuperview()
        }
    }
    
    override func configureView() {
    }
    
}
