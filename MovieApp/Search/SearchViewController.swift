//
//  SearchViewController.swift
//  MovieApp
//
//  Created by YoungJin on 8/3/25.
//

import UIKit

class SearchViewController: BaseViewController {
    
    let searchView = SearchView()
    
    override func loadView() {
        view = searchView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "영화 검색"
        searchView.searchBar.searchTextField.becomeFirstResponder()
    }
    

}
