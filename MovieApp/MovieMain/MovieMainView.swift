//
//  MovieMainView.swift
//  MovieApp
//
//  Created by YoungJin on 8/3/25.
//

import UIKit
import Then
import SnapKit

final class MovieMainView: BaseView {
    
    let profileView = ProfileContainerView()
    
    let recentLabel = UILabel().then {
        $0.text = Text.recent
        $0.font = .systemFont(ofSize: 18, weight: .medium)
        $0.textColor = .white
    }
    
    let allDeleteButton = UIButton().then {
        $0.setTitle(Text.allDelete, for: .normal)
        $0.setTitleColor(.main, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 14)
    }
    
    private let firstlayout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
        $0.minimumLineSpacing = 16
        $0.sectionInset = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        let width = (UIScreen.main.bounds.width - 32 - (16 * 3)) / 4
        $0.itemSize = CGSize(width: width, height: 36)
    }
    
    lazy var recentCollectionView = UICollectionView(frame: .zero, collectionViewLayout: firstlayout).then {
        $0.register(RecentCell.self, forCellWithReuseIdentifier: RecentCell.id)
        $0.backgroundColor = .black
        $0.showsHorizontalScrollIndicator = false
    }
    
    let emptyView = EmptyView(text: Text.searchEmpty)
    
    let todayMovieLabel = UILabel().then {
        $0.text = Text.today
        $0.font = .systemFont(ofSize: 18, weight: .medium)
        $0.textColor = .white
    }
    
    private let secondlayout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
        $0.minimumLineSpacing = 16
        $0.sectionInset = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        $0.itemSize = CGSize(width: 200, height: 300)
    }
    
    lazy var movieCollectionView = UICollectionView(frame: .zero, collectionViewLayout: secondlayout).then {
        $0.register(TodayMovieCell.self, forCellWithReuseIdentifier: TodayMovieCell.id)
        $0.backgroundColor = .black
        $0.showsHorizontalScrollIndicator = false
    }
}

extension MovieMainView {
    override func configureHierarchy() {
        [
            profileView,
            recentLabel, allDeleteButton,
            recentCollectionView,
            emptyView,
            todayMovieLabel,
            movieCollectionView,
        ].forEach {
            addSubview($0)
        }
    }
    
    override func configureLayout() {
        profileView.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
        }
        
        recentLabel.snp.makeConstraints {
            $0.centerY.equalTo(allDeleteButton)
            $0.leading.equalToSuperview().inset(16)
        }
        
        allDeleteButton.snp.makeConstraints {
            $0.top.equalTo(profileView.snp.bottom).offset(20)
            $0.trailing.equalToSuperview().inset(16)
        }
        
        recentCollectionView.snp.makeConstraints {
            $0.top.equalTo(recentLabel.snp.bottom).offset(8)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(52)
        }
        
        emptyView.snp.makeConstraints {
            $0.top.equalTo(profileView.snp.bottom).offset(60)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(40)
        }
        
        todayMovieLabel.snp.makeConstraints {
            $0.top.equalTo(recentCollectionView.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
        
        movieCollectionView.snp.makeConstraints {
            $0.top.equalTo(todayMovieLabel.snp.bottom)
            $0.bottom.horizontalEdges.equalTo(safeAreaLayoutGuide)
        }
    }
}
