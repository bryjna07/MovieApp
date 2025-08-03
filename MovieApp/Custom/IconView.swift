//
//  IconView.swift
//  MovieApp
//
//  Created by YoungJin on 8/4/25.
//

import UIKit
import Then
import SnapKit

final class IconView: BaseView {
    
    private let imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.tintColor = .movieGray
    }
    
    let label = UILabel().then {
        $0.font = .systemFont(ofSize: 12)
        $0.textColor = .movieGray
        $0.textAlignment = .center
        $0.numberOfLines = 0
    }
    
    init(image: UIImage?) {
        super.init(frame: .zero)
        imageView.image = image
    }
}

extension IconView {
    override func configureHierarchy() {
        [
            imageView,
            label,
        ].forEach {
            addSubview($0)
        }
        
    }
    
    override func configureLayout() {
        
        imageView.snp.makeConstraints {
            $0.leading.verticalEdges.equalToSuperview().inset(4)
            $0.width.equalTo(imageView.snp.height)
        }
        
        label.snp.makeConstraints {
            $0.leading.equalTo(imageView.snp.trailing).offset(4)
            $0.verticalEdges.equalToSuperview().inset(4)
            $0.trailing.equalToSuperview()
        }
    }
}
