//
//  CastHeaderView.swift
//  MovieApp
//
//  Created by YoungJin on 8/5/25.
//

import UIKit
import Then
import SnapKit

final class CastHeaderView: UITableViewHeaderFooterView {
    
    private let label = UILabel().then {
        $0.text = "Cast"
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 18, weight: .medium)
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureUI() 
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        backgroundColor = .black
        addSubview(label)
        
        label.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(8)
            $0.verticalEdges.equalToSuperview().inset(8)
        }
    }
}
