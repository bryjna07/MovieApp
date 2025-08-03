//
//  DetailHeaderView.swift
//  MovieApp
//
//  Created by YoungJin on 8/4/25.
//

import UIKit
import Then
import SnapKit

final class DetailHeaderView: UITableViewHeaderFooterView {
    
    static let id = "DetailHeaderView"
    
    private let firstlayout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
        $0.minimumLineSpacing = 0
        $0.sectionInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        $0.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 300)
    }
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: firstlayout).then {
        $0.register(BackdropCell.self, forCellWithReuseIdentifier: BackdropCell.id)
        $0.backgroundColor = .black
        $0.showsHorizontalScrollIndicator = false
        $0.isPagingEnabled = true
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DetailHeaderView: ConfigureUI {
    func configureHierarchy() {
        addSubview(collectionView)
    }
    
    func configureLayout() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func configureView() {
        
    }
 
}
