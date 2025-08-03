//
//  NicknameViewController.swift
//  MovieApp
//
//  Created by YoungJin on 8/2/25.
//

import UIKit

final class NicknameViewController: BaseViewController {
    
    private let nicknameView = NicknameView()
    
    override func loadView() {
        view = nicknameView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = Text.Title.nickname
        navigationController?.navigationBar.isHidden = false
        setupButton()
    }
    
    private func setupButton() {
        nicknameView.editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        nicknameView.completeButton.addTarget(self, action: #selector(completeButtonTapped), for: .touchUpInside)
    }
    
    @objc private func editButtonTapped() {
        let vc = NicknameDetailViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

    @objc private func completeButtonTapped() {
        print(#function)
    }
}
