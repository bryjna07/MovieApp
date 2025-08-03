//
//  MovieDetailViewController.swift
//  MovieApp
//
//  Created by YoungJin on 8/4/25.
//

import UIKit
import Alamofire

final class MovieDetailViewController: BaseViewController {
    
    let detailView = MovieDetailView()
    
    let networkManager = NetworkManager.shared
    
    var movie: Movie?
    
    var backdrop: BackdropInfo?
    var backdropList: [Backdrop] = []
    
    var castInfo: CastInfo?
    var castList: [Cast] = []
    
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
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: Text.SystemImage.heart), style: .plain, target: self, action: #selector(likeButtonTapped))
        setupTableView()
        fetchBackdrop()
        fetchCast()
    }
    
    @objc private func likeButtonTapped() {
        print(#function) /// 유저디폴드 좋아요 상태변경  
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
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SynopsisCell.id, for: indexPath) as? SynopsisCell else { return UITableViewCell() }
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CastCell.id, for: indexPath) as? CastCell else { return UITableViewCell() }
            guard let castInfo else { return cell }
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
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BackdropCell.id, for: indexPath) as? BackdropCell else { return UICollectionViewCell() }
        cell.movie = movie
        guard let backdrop else { return cell }
        cell.backdrop = backdropList[indexPath.item]
        return cell
    }
    
    
}
