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
    
    // detail -> Main 리로드 위한 인덱스
    var detailIndex: Int?
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNaviBar()
        setupCollectionView()
        setupButtonActions()
        setProfile()
//        mainView.recentCollectionView.isHidden = true
        mainView.emptyView.isHidden = true
        requestMovie()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // detail -> Main 좋아요 버튼 상태 업데이트를 위한 리로드
        if let index = detailIndex {
            mainView.movieCollectionView.reloadItems(at: [IndexPath(item: index, section: 0)])
            detailIndex = nil
        }
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
    
    private func setProfile() {
        if let nickname = UserDefaults.standard.string(forKey: "nickname") {
            mainView.profileView.nicknameLabel.text = nickname
        } else {
            mainView.profileView.nicknameLabel.text = "닉네임 없음"
        }
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
            guard let cell = mainView.recentCollectionView.dequeueReusableCell(withReuseIdentifier: RecentCell.identifier, for: indexPath) as? RecentCell else { return UICollectionViewCell() }
            return cell
        } else {
            guard let cell = mainView.movieCollectionView.dequeueReusableCell(withReuseIdentifier: TodayMovieCell.identifier, for: indexPath) as? TodayMovieCell else { return UICollectionViewCell() }
            
            let movie = self.movieList[indexPath.item]
            cell.movie = movie
            
            // 좋아요 버튼 클로저
            cell.likeButtonClosure = {
                let isLiked = !UserDefaultsManager.shared.checkLiked(movieId: movie.id)
                UserDefaultsManager.shared.saveLiked(movieId: movie.id, isLiked: isLiked)
                cell.updateLikeButton()
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == mainView.recentCollectionView {
            let vc = SearchViewController()
            navigationController?.pushViewController(vc, animated: true)
        } else {
            let movie = movieList[indexPath.item]
            detailIndex = indexPath.item
            let vc = MovieDetailViewController(movie: movie)
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
