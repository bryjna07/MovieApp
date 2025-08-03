//
//  MovieMainViewController.swift
//  MovieApp
//
//  Created by YoungJin on 8/3/25.
//

import UIKit

final class MovieMainViewController: BaseViewController {

    let mainView = MovieMainView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNaviBar()
        setupCollectionView()
        setupButtonActions()
//        mainView.recentCollectionView.isHidden = true
        mainView.emptyView.isHidden = true
    }
    
    override func setupNaviBar() {
        super.setupNaviBar()
        navigationItem.title = Text.Title.main
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: Text.SystemImage.magnify), style: .plain, target: self, action: #selector(searchButtonTapped))
    }
    
    private func setupCollectionView() {
        mainView.recentCollectionView.delegate = self
        mainView.recentCollectionView.dataSource = self
        
        mainView.movieCollectionView.delegate = self
        mainView.movieCollectionView.dataSource = self
    }
    
    private func setupButtonActions() {
        mainView.profileView.button.addTarget(self, action: #selector(profileButtonTapped), for: .touchUpInside)
        mainView.allDeleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
    }
    
    @objc private func searchButtonTapped() {
        print(#function)
    }
    
    @objc private func profileButtonTapped() {
        print(#function)
        /// 닉네임 수정 모달 present
    }
    
    @objc private func deleteButtonTapped() {
        print(#function)
        /// 검색기록 전체삭제
    }
    
}

extension MovieMainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == mainView.recentCollectionView {
            return 10
        } else {
            return 10
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == mainView.recentCollectionView {
            guard let cell = mainView.recentCollectionView.dequeueReusableCell(withReuseIdentifier: RecentCell.id, for: indexPath) as? RecentCell else { return UICollectionViewCell() }
            return cell
        } else {
            guard let cell = mainView.movieCollectionView.dequeueReusableCell(withReuseIdentifier: TodayMovieCell.id, for: indexPath) as? TodayMovieCell else { return UICollectionViewCell() }
            return cell
        }
    }
}
