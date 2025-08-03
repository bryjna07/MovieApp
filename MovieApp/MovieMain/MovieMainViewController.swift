//
//  MovieMainViewController.swift
//  MovieApp
//
//  Created by YoungJin on 8/3/25.
//

import UIKit
import Alamofire

final class MovieMainViewController: BaseViewController {

    let mainView = MovieMainView()
    
    let networkManager = NetworkManager.shared
    
    var recentSearchList: [String] = []
    
    var movie: MovieInfo?
    
    var movieList: [Movie] = []
    
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
        requestMovie()
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
        let vc = SearchViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func profileButtonTapped() {
        print(#function)
        /// 닉네임 수정 모달 present
    }
    
    @objc private func deleteButtonTapped() {
        print(#function)
        /// 검색기록 전체삭제
    }
    
    private func requestMovie() {
        guard let url = networkManager.makeURL(path: MovieAPI.Path.trending.rawValue) else { return }
        print(url.absoluteString)
        networkManager.fetchData(url: url) {  [weak self] (result: Result<MovieInfo, AFError>) in
            guard let self else { return }
            switch result {
            case .success(let movie):
                self.movie = movie
                self.movieList = movie.results
                mainView.movieCollectionView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension MovieMainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == mainView.recentCollectionView {
            return recentSearchList.count
        } else {
            return movieList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == mainView.recentCollectionView {
            guard let cell = mainView.recentCollectionView.dequeueReusableCell(withReuseIdentifier: RecentCell.id, for: indexPath) as? RecentCell else { return UICollectionViewCell() }
            return cell
        } else {
            guard let cell = mainView.movieCollectionView.dequeueReusableCell(withReuseIdentifier: TodayMovieCell.id, for: indexPath) as? TodayMovieCell else { return UICollectionViewCell() }
            cell.movie = movieList[indexPath.item]
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == mainView.recentCollectionView {
            let vc = SearchViewController()
            navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc = MovieDetailViewController(title: "TEST")
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension MovieMainViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == mainView.movieCollectionView {
            let height = collectionView.bounds.height
            return CGSize(width: height / 2, height: height)
        } else {
            
            let width = (UIScreen.main.bounds.width - 32 - (16 * 3)) / 4
            return CGSize(width: width, height: 36)
        }
    }
}
