//
//  MovieMainViewController.swift
//  MovieApp
//
//  Created by YoungJin on 8/3/25.
//

import UIKit
import Alamofire

final class MovieMainViewController: BaseViewController {

    private let mainView = MovieMainView()
    private let networkManager = NetworkManager.shared
    private let userDefaultsManager = UserDefaultsManager.shared
    
    private var recentSearchList: [String] = []
    private var movie: MovieInfo?
    private var movieList: [Movie] = []
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNaviBar()
        setupCollectionView()
        setupButtonActions()
        setProfile()
        requestMovie()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let array = userDefaultsManager.getRecent() {
            recentSearchList = array
            mainView.recentCollectionView.reloadData()
        }
        replaceEmptyView()
        mainView.movieCollectionView.reloadData()
        updateMovieBox()
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
    
    // 서치뷰 화면이동
    @objc private func searchButtonTapped() {
        let vc = SearchViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // 프로필 버튼 -> 닉네임 수정 모달
    @objc private func profileButtonTapped() {
        let vc = NicknameViewController(type: .edit)
        let naviVC = UINavigationController(rootViewController: vc)
        vc.nickNameUpdateClosure = { [weak self] in
            self?.setProfile()
        }
        if let sheet = naviVC.sheetPresentationController {
            sheet.detents = [.large()]
            sheet.prefersGrabberVisible = true
        }
        present(naviVC, animated: true)
    }
    
    // 전체삭제 버튼 액션
    @objc private func deleteButtonTapped() {
        userDefaultsManager.allDeleteRecent()
        recentSearchList = []
        mainView.recentCollectionView.reloadData()
        replaceEmptyView()
    }
    
    // 프로필뷰 세팅
    private func setProfile() {
        if let nickname = userDefaultsManager.getNickname() {
            mainView.profileView.nicknameLabel.text = nickname
        } else {
            mainView.profileView.nicknameLabel.text = "닉네임 없음"
        }
    }
    
    // 무비박스 갯수 업데이트
    private func updateMovieBox() {
        let likeCount = userDefaultsManager.getlikeCount()
        mainView.profileView.movieBoxLabel.text = "\(likeCount)개의 무비박스 보관중"
    }
    
    // 최근검색어 없을 시 예외처리
    private func replaceEmptyView() {
        if recentSearchList == [] {
            mainView.recentCollectionView.isHidden = true
            mainView.emptyView.isHidden = false
            mainView.allDeleteButton.isHidden = true
        } else {
            mainView.recentCollectionView.isHidden = false
            mainView.emptyView.isHidden = true
            mainView.allDeleteButton.isHidden = false
        }
    }
    
    private func requestMovie() {
        guard let url = networkManager.makeURL(path: MovieAPI.Path.trending.rawValue) else { return }
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

//MARK: - CollectionView Protocols
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
            let recent = recentSearchList[indexPath.row]
            cell.recent = recent
            
            // 최근검색어 개별 삭제 클로저
            cell.deleteButtonClosure = { [weak self] in
                guard let self else { return }
                self.userDefaultsManager.deleteRecent(recent)
                if let array = self.userDefaultsManager.getRecent() {
                    self.recentSearchList = array
                    self.replaceEmptyView()
                }
                self.mainView.recentCollectionView.reloadData()
            }
            return cell
            
        } else {
            guard let cell = mainView.movieCollectionView.dequeueReusableCell(withReuseIdentifier: TodayMovieCell.identifier, for: indexPath) as? TodayMovieCell else { return UICollectionViewCell() }
            
            let movie = self.movieList[indexPath.item]
            
            // 좋아요 버튼 클로저
            cell.likeButtonClosure = { [weak self] in
                let isLiked = !UserDefaultsManager.shared.checkLiked(movieId: movie.id)
                UserDefaultsManager.shared.saveLiked(movieId: movie.id, isLiked: isLiked)
                cell.updateLikeButton()
                self?.updateMovieBox()
            }
            cell.movie = movie
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == mainView.recentCollectionView {
            let vc = SearchViewController(search: recentSearchList[indexPath.row])
            navigationController?.pushViewController(vc, animated: true)
        } else {
            let movie = movieList[indexPath.item]
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
