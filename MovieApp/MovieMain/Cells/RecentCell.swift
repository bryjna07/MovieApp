//
//  RecentCell.swift
//  MovieApp
//
//  Created by YoungJin on 8/3/25.
//

import UIKit
import Then
import SnapKit

final class RecentCell: BaseCollectionViewCell {
    
    var recent: String? {
        didSet {
            configureUIWithData()
        }
    }
    
    var deleteButtonClosure: (() -> Void)?
    
    private let nameLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14)
        $0.textColor = .black
    }
    
    private let deletButton = UIButton().then {
        $0.setImage(UIImage(systemName: Text.SystemImage.xmark), for: .normal)
        $0.tintColor = .black
    }

}

extension RecentCell {
    
    override func configureUIWithData() {
        guard let recent else { return }
        nameLabel.text = recent
    }
    
    override func configureHierarchy() {
        [
            nameLabel,
            deletButton
        ].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func configureLayout() {
        nameLabel.snp.makeConstraints {
            $0.leading.verticalEdges.equalToSuperview().inset(8)
        }
        
        deletButton.snp.makeConstraints {
            $0.leading.greaterThanOrEqualTo(nameLabel.snp.trailing).offset(8)
            $0.verticalEdges.trailing.equalToSuperview().inset(8)
            $0.width.equalTo(16)
        }
    }
    
    override func configureView() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 16
        contentView.clipsToBounds = true
        deletButton.addTarget(self, action: #selector(deletButtonTapped), for: .touchUpInside)
    }
    
    @objc private func deletButtonTapped() {
        deleteButtonClosure?()
    }
    
}
