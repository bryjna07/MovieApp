//
//  BackdropCell.swift
//  MovieApp
//
//  Created by YoungJin on 8/4/25.
//

import UIKit
import Then
import SnapKit

final class BackdropCell: BaseCollectionViewCell {
    
    var movie: Movie? {
        didSet {
            configureUIWithData()
        }
    }
    
    var backdrop: Backdrop? {
        didSet {
            setupBackdrop()
        }
    }
    
    var backdropCount: Int? {
        didSet {
            guard let count = backdropCount else { return }
            pageControll.numberOfPages = min(count, 5)
        }
    }
    
    var index: Int? {
        didSet {
            guard let index else { return }
            pageControll.currentPage = index
            }
        }
    
    private let imageView = UIImageView()
    
    private let pageControll = UIPageControl().then {
        $0.backgroundColor = .darkGray
        $0.layer.cornerRadius = 8
    }
    
    private let dateIconView = IconView(image: UIImage(systemName: Text.SystemImage.calendar))
    
    private let dividerView = UIView().then {
        $0.backgroundColor = .movieGray
    }
    
    private let starIconView = IconView(image: UIImage(systemName: Text.SystemImage.star))
    
    private let secondDividerView = UIView().then {
        $0.backgroundColor = .movieGray
    }
    
    private let filmIconView = IconView(image: UIImage(systemName: Text.SystemImage.film))
    
    override func prepareForReuse() {
        imageView.image = nil
    }
}

extension BackdropCell {
    
    override func configureUIWithData() {
        guard let movie else { return }
        dateIconView.label.text = movie.releaseDate
        starIconView.label.text = "\(movie.transformAverage)"
        filmIconView.label.text = movie.transformGenreArray.joined(separator: ", ")
    }
    
    private func setupBackdrop() {
        guard let backdrop else { return }
        let imageURL = backdrop.filePath
        let urlString = MovieImage.movieImageURL(size: 200, posterPath: imageURL)
        let url = URL(string: urlString)
        imageView.setKFImage(from: url)
    }
    
    override func configureHierarchy() {
        
        imageView.addSubview(pageControll)
        
        [
            imageView,
            dateIconView, dividerView,
            starIconView, secondDividerView,
            filmIconView,
        ].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func configureLayout() {
        
        imageView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
        }
        
        pageControll.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(8)
            $0.centerX.equalToSuperview()
        }
        
        dateIconView.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(16)
            $0.leading.equalToSuperview().inset(40)
            $0.bottom.equalToSuperview().inset(8)
        }
        
        dividerView.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(16)
            $0.leading.equalTo(dateIconView.snp.trailing).offset(8)
            $0.height.equalTo(dateIconView.snp.height)
            $0.width.equalTo(1)
        }
        
        starIconView.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(16)
            $0.leading.equalTo(dividerView.snp.trailing).offset(4)
            $0.bottom.equalToSuperview().inset(8)
        }
        
        secondDividerView.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(16)
            $0.leading.equalTo(starIconView.snp.trailing).offset(8)
            $0.height.equalTo(starIconView.snp.height)
            $0.width.equalTo(1)
        }
        
        filmIconView.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(16)
            $0.leading.equalTo(secondDividerView.snp.trailing).offset(8)
            $0.bottom.equalToSuperview().inset(8)
        }
        
    }
}
