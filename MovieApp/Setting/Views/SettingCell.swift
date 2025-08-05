//
//  SettingCell.swift
//  MovieApp
//
//  Created by YoungJin on 8/4/25.
//

import UIKit
import Then
import SnapKit

final class SettingCell: BaseTableViewCell {
    
    let label = UILabel().then {
        $0.font = .systemFont(ofSize: 16)
        $0.textColor = .white
    }
}

extension SettingCell {
    
    override func configureHierarchy() {
        contentView.addSubview(label)
    }
    
    override func configureLayout() {
        
        label.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16)
        }
    }
    
    override func configureView() {
        super.configureView()
        selectionStyle = .none
    }
}
