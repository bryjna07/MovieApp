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
    
    lazy var tableView = UITableView().then {
        $0.register(DetailHeaderView.self, forHeaderFooterViewReuseIdentifier: DetailHeaderView.id)
        $0.register(SynopsisCell.self, forCellReuseIdentifier: SynopsisCell.id)
        $0.register(CastCell.self, forCellReuseIdentifier: CastCell.id)
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
