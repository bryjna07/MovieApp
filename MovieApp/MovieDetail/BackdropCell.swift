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
    
    static let id = "BackdropCell"
    
    private let imageView = UIImageView().then {
        $0.backgroundColor = .main
    }
    
    private let pageControll = UIPageControl().then {
        $0.backgroundColor = .movieGray
        $0.numberOfPages = 5
    }
    
    private let dateIconView = IconView(image: UIImage(systemName: Text.SystemImage.calendar), text: "2024-12-24")
    
    private let dividerView = UIView().then {
        $0.backgroundColor = .movieGray
    }
    
    private let starIconView = IconView(image: UIImage(systemName: Text.SystemImage.star), text: "9.0")
    
    private let secondDividerView = UIView().then {
        $0.backgroundColor = .movieGray
    }
    
    private let filmIconView = IconView(image: UIImage(systemName: Text.SystemImage.star), text: "액션, 스릴러")
}

extension BackdropCell {
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
            $0.leading.equalTo(dateIconView.snp.trailing).offset(4)
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
            $0.leading.equalTo(starIconView.snp.trailing).offset(4)
            $0.height.equalTo(starIconView.snp.height)
            $0.width.equalTo(1)
        }
        
        filmIconView.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(16)
            $0.leading.equalTo(secondDividerView.snp.trailing).offset(4)
            $0.bottom.equalToSuperview().inset(8)
        }
        
    }
}
