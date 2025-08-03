//
//  EmptyView.swift
//  MovieApp
//
//  Created by YoungJin on 8/3/25.
//

import UIKit
import Then
import SnapKit

final class EmptyView: BaseView {
    
    private let label = UILabel().then {
        $0.font = .systemFont(ofSize: 16)
        $0.textColor = .movieGray
        $0.textAlignment = .center
        $0.numberOfLines = 0
    }
    
    init(text: String) {
        super.init(frame: .zero)
        label.text = text
    }
}

extension EmptyView {
    override func configureHierarchy() {
        addSubview(label)
    }
    
    override func configureLayout() {
        label.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
