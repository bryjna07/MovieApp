//
//  MovieDetailView.swift
//  MovieApp
//
//  Created by YoungJin on 8/4/25.
//

import UIKit
import Then
import SnapKit

final class MovieDetailView: BaseView {
    
    let headerView = DetailHeaderView()
    
    lazy var tableView = UITableView().then {
        headerView.frame = CGRect(x: 0, y: 0, width: $0.bounds.width, height: 300)
        $0.tableHeaderView = headerView
        $0.register(CastHeaderView.self, forHeaderFooterViewReuseIdentifier: CastHeaderView.identifier)
        $0.register(SynopsisCell.self, forCellReuseIdentifier: SynopsisCell.identifier)
        $0.register(CastCell.self, forCellReuseIdentifier: CastCell.identifier)
        $0.rowHeight = UITableView.automaticDimension
        $0.backgroundColor = .black
        $0.allowsSelection = false
    }
}

extension MovieDetailView {
    override func configureHierarchy() {
        addSubview(tableView)
    }
    
    override func configureLayout() {
        tableView.snp.makeConstraints {
            $0.edges.equalTo(safeAreaLayoutGuide)
        }
    }
}
