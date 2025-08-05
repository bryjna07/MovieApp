//
//  DetailHeaderView.swift
//  MovieApp
//
//  Created by YoungJin on 8/4/25.
//

import UIKit
import Then
import SnapKit

final class DetailHeaderView: BaseView {
    
    private let firstlayout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
        $0.minimumLineSpacing = 0
        $0.sectionInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        $0.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 300)
    }
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: firstlayout).then {
        $0.register(BackdropCell.self, forCellWithReuseIdentifier: BackdropCell.identifier)
        $0.backgroundColor = .black
        $0.showsHorizontalScrollIndicator = false
        $0.isPagingEnabled = true
    }
}

extension DetailHeaderView {
    override func configureHierarchy() {
        addSubview(collectionView)
    }
    
    override func configureLayout() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
