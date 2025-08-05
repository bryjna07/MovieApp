//
//  SettingView.swift
//  MovieApp
//
//  Created by YoungJin on 8/4/25.
//

import UIKit
import Then
import SnapKit

final class SettingView: BaseView {
    
    let profileView = ProfileContainerView()
    
    lazy var tableView = UITableView().then {
        $0.register(SettingCell.self, forCellReuseIdentifier: SettingCell.identifier)
        $0.backgroundColor = .black
        $0.rowHeight = UITableView.automaticDimension
        $0.separatorColor = .darkGray
    }
}

extension SettingView {
    override func configureHierarchy() {
        [
            profileView,
            tableView,
        ].forEach {
            addSubview($0)
        }
    }
    
    override func configureLayout() {
        profileView.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(profileView.snp.bottom).offset(16)
            $0.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            $0.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
}

