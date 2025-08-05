//
//  NicknameView.swift
//  MovieApp
//
//  Created by YoungJin on 8/2/25.
//

import UIKit
import Then
import SnapKit

final class NicknameView: BaseView {
    
    var type: NicknameType
    
    let nicknameLabel = UILabel().then {
        $0.textColor = .movieGray
        $0.font = .systemFont(ofSize: 16)
    }
    
    let editButton = CustomButton(title: "편집", color: .white, width: 0.8)
    
    private let lineView = UIView().then {
        $0.backgroundColor = .movieGray
    }
    
    let completeButton = CustomButton(title: "완료", color: .main, width: 1)
    
    init(type: NicknameType) {
        self.type = type
        super.init(frame: .zero)
    }
}

extension NicknameView {
    override func configureHierarchy() {
        [
            nicknameLabel,
            editButton,
            lineView,
            completeButton,
        ].forEach {
            addSubview($0)
        }
    }
    
    override func configureLayout() {
        nicknameLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).inset(20)
            $0.leading.equalToSuperview().inset(24)
            $0.height.equalTo(44)
            $0.trailing.equalTo(editButton.snp.leading)
        }
        
        editButton.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).inset(20)
            $0.trailing.equalToSuperview().inset(16)
            $0.width.equalTo(68)
            $0.height.equalTo(44)
        }
        
        lineView.snp.makeConstraints {
            $0.top.equalTo(nicknameLabel.snp.bottom)
            $0.leading.equalToSuperview().inset(16)
            $0.trailing.equalToSuperview().inset(32)
            $0.height.equalTo(0.5)
        }
        
        completeButton.snp.makeConstraints {
            $0.top.equalTo(lineView.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(44)
        }
    }
    
    override func configureView() {
        super.configureView()
        switch type {
        case .new:
            return
        case .edit:
            return completeButton.isHidden = true
        }
    }
}
