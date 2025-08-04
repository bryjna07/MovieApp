//
//  SynopsisCell.swift
//  MovieApp
//
//  Created by YoungJin on 8/4/25.
//

import UIKit
import Then
import SnapKit

final class SynopsisCell: BaseTableViewCell {
    
    let synopsisLabel = UILabel().then {
        $0.text = "Synopsis"
        $0.font = .systemFont(ofSize: 16)
        $0.textColor = .white
    }
    
    let button = UIButton().then {
        $0.setTitle("More", for: .normal)
        $0.setTitleColor(.main, for: .normal)
    }
    
    let explainLabel = UILabel().then {
        $0.text = "Synopsis"
        $0.font = .systemFont(ofSize: 14)
        $0.textColor = .white
        $0.numberOfLines = 3
    }
    
}

extension SynopsisCell {
    override func configureHierarchy() {
        [
            synopsisLabel,
            button,
            explainLabel,
        ].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func configureLayout() {
        synopsisLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(8)
        }
        
        button.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(8)
        }
        
        explainLabel.snp.makeConstraints {
            $0.top.equalTo(synopsisLabel.snp.bottom).offset(8)
            $0.horizontalEdges.bottom.equalToSuperview().inset(8)
        }
    }
}
