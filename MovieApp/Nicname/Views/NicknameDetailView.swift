//
//  NicknameDetailView.swift
//  MovieApp
//
//  Created by YoungJin on 8/2/25.
//


import UIKit
import Then
import SnapKit

final class NicknameDetailView: BaseView {
    
    let textField = UITextField().then {
        $0.placeholder = "닉네임을 정해보세요!"
        $0.attributedPlaceholder = NSAttributedString(string: $0.placeholder ?? "", attributes: [.foregroundColor : UIColor.systemGray]) // 플레이스홀더 색상
        $0.backgroundColor = .black
        $0.borderStyle = .roundedRect
        $0.textColor = .white
        $0.tintColor = .white
        $0.layer.borderColor = UIColor.white.cgColor
        $0.returnKeyType = .done
    }
    
    private let lineView = UIView().then {
        $0.backgroundColor = .movieGray
    }
    
    let validLabel = UILabel().then {
        $0.textColor = .main
        $0.font = .systemFont(ofSize: 14)
    }
    
}

extension NicknameDetailView {
    override func configureHierarchy() {
        [
            textField,
            lineView,
            validLabel
        ].forEach {
            addSubview($0)
        }
    }
    
    override func configureLayout() {
        textField.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).inset(20)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(44)
        }
        
        lineView.snp.makeConstraints {
            $0.top.equalTo(textField.snp.bottom)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(0.5)
        }
        
        validLabel.snp.makeConstraints {
            $0.top.equalTo(lineView.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(24)
        }
    }
    
}
