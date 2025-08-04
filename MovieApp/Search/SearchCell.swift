//
//  SearchCell.swift
//  MovieApp
//
//  Created by YoungJin on 8/4/25.
//


import UIKit
import Then
import SnapKit

final class SearchCell: BaseTableViewCell {
    
    var movie: Movie? {
        didSet {
            configureUIWithData()
        }
    }
    
    private let movieImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
    }
    
    private let nameLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16)
        $0.textColor = .white
        $0.numberOfLines = 2
    }
    
    /// date 표기 변경 필요
    private let dateLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14)
        $0.textColor = .movieGray
    }
    
    private let firstTagLabel = GenreTagLabel(title: "장르1")
    
    private let secondTagLabel = GenreTagLabel(title: "장르2")
    
    private let tagStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 4
        $0.distribution = .equalSpacing
    }
    
    let likeButton = UIButton().then {
        $0.setImage(UIImage(systemName: Text.SystemImage.heart), for: .normal)
        $0.tintColor = .main
    }
    
}

extension SearchCell {
    
    override func configureUIWithData() {
        guard let movie else { return }
        nameLabel.text = movie.title
        dateLabel.text = movie.releaseDate
        guard let imageURL = movie.posterPath else { return }
        let urlString = MovieImage.movieImageURL(size: 200, posterPath: imageURL)
        let url = URL(string: urlString)
        movieImageView.setKFImage(from: url)
    }
    
    override func configureHierarchy() {
        [
            firstTagLabel,
            secondTagLabel,
        ].forEach {
            tagStackView.addArrangedSubview($0)
        }
        
        [
            movieImageView,
            nameLabel,
            dateLabel,
            tagStackView,
            likeButton
        ].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func configureLayout() {
        
        firstTagLabel.snp.makeConstraints {
            $0.width.equalTo(36)
        }
        
        secondTagLabel.snp.makeConstraints {
            $0.width.equalTo(36)
        }
        
        movieImageView.snp.makeConstraints {
            $0.leading.verticalEdges.equalToSuperview().inset(16)
            $0.width.equalTo(80)
        }
        
        nameLabel.snp.makeConstraints {
            $0.leading.equalTo(movieImageView.snp.trailing).offset(16)
            $0.top.trailing.equalToSuperview().inset(16)
        }
        
        dateLabel.snp.makeConstraints {
            $0.leading.equalTo(movieImageView.snp.trailing).offset(16)
            $0.top.equalTo(nameLabel.snp.bottom).offset(4)
            $0.trailing.equalToSuperview().inset(16)
        }
        
        tagStackView.snp.makeConstraints {
            $0.leading.equalTo(movieImageView.snp.trailing).offset(16)
            $0.bottom.equalToSuperview().inset(16)
        }
        
        likeButton.snp.makeConstraints {
            $0.bottom.trailing.equalToSuperview().inset(16)
            $0.size.equalTo(20)
        }
    }
}
