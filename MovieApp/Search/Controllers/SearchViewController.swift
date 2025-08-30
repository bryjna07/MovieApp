//
//  SearchViewController.swift
//  MovieApp
//
//  Created by YoungJin on 8/3/25.
//

import UIKit
import Alamofire

final class SearchViewController: BaseViewController {
    
    private let searchView = SearchView()
    
    private let networkManager = NetworkManager.shared
    
    var movie: MovieInfo?
    
    // detail -> Search 리로드 위한 인덱스
    var detailIndex: Int?
    
    var list: [Movie] = []
    
    var currentPage = 1
    
    init(search: String? = nil) {
        super.init(nibName: nil, bundle: nil)
        if let search {
            searchView.searchBar.text = search
            fetchSearchMovie(searchText: search)
        } else {
            searchView.searchBar.searchTextField.becomeFirstResponder()
        }
    }
    
    override func loadView() {
        view = searchView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "영화 검색"
        setupDelegates()
        searchView.emptyView.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // detail -> Search 좋아요 버튼 상태 업데이트를 위한 리로드
        if let index = detailIndex {
            searchView.tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
            detailIndex = nil
        }
    }
    
    private func setupDelegates() {
        searchView.searchBar.delegate = self
        searchView.tableView.delegate = self
        searchView.tableView.dataSource = self
        searchView.tableView.prefetchDataSource = self
    }
    
    private func replaceEmptyView() {
        if list == [] {
            searchView.emptyView.isHidden = false
            searchView.tableView.isHidden = true
        } else {
            searchView.emptyView.isHidden = true
            searchView.tableView.isHidden = false
        }
    }
    
    func fetchSearchMovie(searchText: String) {
        let router = Router.movie(.search(query: searchText, page: 1))
        networkManager.fetchData(router) {  [weak self] (result: Result<MovieInfo, AFError>) in
            guard let self else { return }
            switch result {
            case .success(let movie):
                self.movie = movie
                self.list = movie.results
                replaceEmptyView()
                searchView.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func prefetchMovie(page: Int = 2) {
        guard let text = searchView.searchBar.text else { return }
        let router = Router.movie(.search(query: text, page: page))
        networkManager.fetchData(router) {  [weak self] (result: Result<MovieInfo, AFError>) in
            guard let self else { return }
            switch result {
            case .success(let movie):
                self.movie = movie
                self.list.append(contentsOf: movie.results)
                self.currentPage += 1
                searchView.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchCell.identifier, for: indexPath) as? SearchCell else { return UITableViewCell() }
        
        let movie = list[indexPath.row]
        
        // 좋아요 버튼 클로저
        cell.likeButtonClosure = {
            let isLiked = !UserDefaultsManager.shared.checkLiked(movieId: movie.id)
            UserDefaultsManager.shared.saveLiked(movieId: movie.id, isLiked: isLiked)
            cell.updateLikeButton()
        }
        
        cell.movie = movie
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = list[indexPath.row]
        detailIndex = indexPath.row
        let vc = MovieDetailViewController(movie: movie)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        fetchSearchMovie(searchText: text)
        view.endEditing(true)
        UserDefaultsManager.shared.saveRecent(text)
    }
}

extension SearchViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        
        let lastItem = indexPaths.map { $0.item }.sorted(by: <).last
        
        guard let lastItem else { return }
        if lastItem >= list.count - 5 {
            guard let text = searchView.searchBar.text else { return }
            prefetchMovie(page: currentPage)
        }
    }
}
