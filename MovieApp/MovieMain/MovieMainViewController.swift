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
        navigationItem.title = Text.Title.main
    }
    
}
