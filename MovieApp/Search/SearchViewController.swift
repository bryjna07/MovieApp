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
    
    var list: [Movie] = []
    
    override func loadView() {
        view = searchView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "영화 검색"
        searchView.searchBar.searchTextField.becomeFirstResponder()
        searchView.searchBar.delegate = self
        searchView.tableView.delegate = self
        searchView.tableView.dataSource = self
    }
    

}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchCell.identifier, for: indexPath) as? SearchCell else { return UITableViewCell() }
        cell.movie = list[indexPath.row]
        return cell
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        let query: [URLQueryItem] = [
            URLQueryItem(name: "query", value: text),
            URLQueryItem(name: "include_adult", value: "false"),
        ]
        guard let url = networkManager.makeURL(path: MovieAPI.Path.search.rawValue, query: query) else { return }
        networkManager.fetchData(url: url) {  [weak self] (result: Result<MovieInfo, AFError>) in
            guard let self else { return }
            switch result {
            case .success(let movie):
                self.movie = movie
                self.list = movie.results
                searchView.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}

///TODO: 페이지네이션, 좋아요 버튼, 최근검색어 -> 화면이동 + 셀표시
/// 최근검색어로 이동 시 키보드 내려진 상태로
/// 검색결과 없는 경우
