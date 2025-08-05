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
        fetchBackdrop()
        fetchCast()
    }
    
    override func setupNaviBar() {
        super.setupNaviBar()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: Text.SystemImage.heart), style: .plain, target: self, action: #selector(likeButtonTapped))
        updateLikeButton()
    }
    
    private func updateLikeButton() {
        guard let movie = movie else { return }
        
        let isLiked = userDefaultsManager.checkLiked(movieId: movie.id)
        let imageName = isLiked ? Text.SystemImage.heartFill : Text.SystemImage.heart
        navigationItem.rightBarButtonItem?.image = UIImage(systemName: imageName)
    }
    
    @objc private func likeButtonTapped() {
        guard let movie else { return }
        
        let isLiked = !userDefaultsManager.checkLiked(movieId: movie.id)
        userDefaultsManager.saveLiked(movieId: movie.id, isLiked: isLiked)
        updateLikeButton()
    }
    
    private func setupTableView() {
        detailView.tableView.delegate = self
        detailView.tableView.dataSource = self
    }
    
    private func fetchBackdrop() {
        guard let movie, let url = URL(string: MovieImage.backdropURL(id: movie.id)) else { return }
        print(url.absoluteString)
        networkManager.fetchData(url: url) { [weak self] (result: Result<BackdropInfo, AFError>) in
            guard let self else { return }
            switch result {
            case .success(let backdrop):
                self.backdrop = backdrop
                self.backdropList = backdrop.backdrops
                detailView.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func fetchCast() {
        guard let movie, let url = URL(string: MovieImage.creditURL(id: movie.id)) else { return }
        print(url.absoluteString)
        networkManager.fetchData(url: url) { [weak self] (result: Result<CastInfo, AFError>) in
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
    
    // 시놉시스 셀 줄거리 More 버튼
    @objc private func moreButtonTapped() {
        isMoreSynopsis.toggle()
        detailView.tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
    }
}

extension MovieDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return 10
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
        if section == 0 {
            guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: DetailHeaderView.id) as? DetailHeaderView else {
                return nil
            }
            header.collectionView.delegate = self
            header.collectionView.dataSource = self
            header.collectionView.reloadData()
            return header
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1 {
            return "Cast"
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 300
        } else {
            return 30
        }
    }
}

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
