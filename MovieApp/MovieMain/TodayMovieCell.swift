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
    
    var movie: Movie? {
        didSet {
            configureUIWithData()
        }
    }
    
    var likeButtonClosure: (()-> Void)?
    
    private let imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
    }
    
    private let nameLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16)
        $0.textColor = .white
    }
    
    let likeButton = UIButton().then {
        $0.setImage(UIImage(systemName: Text.SystemImage.heart), for: .normal)
        $0.tintColor = .main
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
        updateLikeButton()
    }
    
    func updateLikeButton() {
        guard let movie else { return }
        let isLiked = UserDefaultsManager.shared.checkLiked(movieId: movie.id)
        let imageName = isLiked ? Text.SystemImage.heartFill : Text.SystemImage.heart
        likeButton.setImage(UIImage(systemName: imageName), for: .normal)
    }
    
    override func configureHierarchy() {
        [
            imageView,
            nameLabel,
            likeButton,
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
            $0.leading.equalToSuperview()
            $0.trailing.equalTo(likeButton.snp.leading).offset(-2)
        }
        
        likeButton.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(8)
            $0.trailing.equalToSuperview()
            $0.size.equalTo(20)
        }
        
        explainLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(8)
            $0.horizontalEdges.equalToSuperview()
        }
    }
    
    override func configureView() {
        likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
    }
    
    @objc private func likeButtonTapped() {
        likeButtonClosure?()
    }
}
