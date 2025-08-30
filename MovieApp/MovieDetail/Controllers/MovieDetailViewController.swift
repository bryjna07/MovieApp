//
//  MovieDetailViewController.swift
//  MovieApp
//
//  Created by YoungJin on 8/4/25.
//

import UIKit
import Alamofire

final class MovieDetailViewController: BaseViewController {
    
    private let detailView = MovieDetailView()
    private let networkManager = NetworkManager.shared
    private let userDefaultsManager = UserDefaultsManager.shared
    
    private var movie: Movie?
    
    private var backdrop: BackdropInfo?
    private var backdropList: [Backdrop] = []
    private var isMoreSynopsis = false
    
    private var castInfo: CastInfo?
    private var castList: [Cast] = []
    
    init(movie: Movie) {
        super.init(nibName: nil, bundle: nil)
        self.movie = movie
        navigationItem.title = movie.title
    }
    
    override func loadView() {
        view = detailView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupHeaderCollectionView()
        fetchBackdrop()
        fetchCast()
    }
    
    //MARK: - setup
    
    override func setupNaviBar() {
        super.setupNaviBar()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: Text.SystemImage.heart), style: .plain, target: self, action: #selector(likeButtonTapped))
        updateLikeButton()
    }
    
    private func setupTableView() {
        detailView.tableView.delegate = self
        detailView.tableView.dataSource = self
    }
    
    private func setupHeaderCollectionView() {
        detailView.headerView.collectionView.delegate = self
        detailView.headerView.collectionView.dataSource = self
    }
    
    //MARK: - Logic
    
    // 좋아요 상태 업데이트
    private func updateLikeButton() {
        guard let movie = movie else { return }
        
        let isLiked = userDefaultsManager.checkLiked(movieId: movie.id)
        let imageName = isLiked ? Text.SystemImage.heartFill : Text.SystemImage.heart
        navigationItem.rightBarButtonItem?.image = UIImage(systemName: imageName)
    }
    
    // 좋아요 버튼 클릭 액션
    @objc private func likeButtonTapped() {
        guard let movie else { return }
        
        let isLiked = !userDefaultsManager.checkLiked(movieId: movie.id)
        userDefaultsManager.saveLiked(movieId: movie.id, isLiked: isLiked)
        updateLikeButton()
    }
    
    // 시놉시스 셀 줄거리 More 버튼
    @objc private func moreButtonTapped() {
        isMoreSynopsis.toggle()
        detailView.tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
    }
    
    //MARK: - Networking
    
    private func fetchBackdrop() {
        guard let movie else { return }
        let router = Router.movie(.backdrop(id: movie.id))
        networkManager.fetchData(router) { [weak self] (result: Result<BackdropInfo, AFError>) in
            guard let self else { return }
            switch result {
            case .success(let backdrop):
                self.backdrop = backdrop
                self.backdropList = backdrop.backdrops
                detailView.headerView.collectionView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func fetchCast() {
        guard let movie else { return }
        let router = Router.movie(.credit(id: movie.id))
        networkManager.fetchData(router) { [weak self] (result: Result<CastInfo, AFError>) in
            guard let self else { return }
            switch result {
            case .success(let cast):
                self.castInfo = cast
                self.castList = cast.cast
                detailView.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}

//MARK: - TableView Protocols
extension MovieDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return castList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SynopsisCell.identifier, for: indexPath) as? SynopsisCell else { return UITableViewCell() }
            cell.movie = movie
            cell.explainLabel.numberOfLines = isMoreSynopsis ? 0 : 3
            cell.button.setTitle(isMoreSynopsis ? "Hide" : "More", for: .normal)
            cell.button.addTarget(self, action: #selector(moreButtonTapped), for: .touchUpInside)
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CastCell.identifier, for: indexPath) as? CastCell else { return UITableViewCell() }
            guard castInfo != nil else { return cell }
            cell.cast = castList[indexPath.row]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: CastHeaderView.identifier) as? CastHeaderView else { return nil }
            return view
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return 30
        } else {
            return 0
        }
    }
}

//MARK: - CollectionView Protocols
// 테이블뷰의 헤더뷰 안에 있는 컬렉션뷰
extension MovieDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return min(backdropList.count, 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BackdropCell.identifier, for: indexPath) as? BackdropCell else { return UICollectionViewCell() }
        cell.movie = movie
        guard backdrop != nil else { return cell }
        cell.backdrop = backdropList[indexPath.item]
        cell.backdropCount = backdropList.count
        cell.index = indexPath.item
        return cell
    }
}
