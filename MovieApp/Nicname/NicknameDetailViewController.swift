//
//  NicknameDetailViewController.swift
//  MovieApp
//
//  Created by YoungJin on 8/2/25.
//

import UIKit

final class NicknameDetailViewController: BaseViewController {
    
    let detailView = NicknameDetailView()
    
    override func loadView() {
        view = detailView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = Text.Title.nickname
        
    }

}
