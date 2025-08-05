//
//  ProfileContainerView.swift
//  MovieApp
//
//  Created by YoungJin on 8/3/25.
//

import UIKit
import Then
import SnapKit

final class ProfileContainerView: BaseView {

    let nicknameLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 18, weight: .medium)
        $0.textColor = .white
    }
    
    let button = UIButton().then {
        var config = UIButton.Configuration.plain()
        config.imagePlacement = .trailing
        config.imagePadding = 8
        $0.setTitle("25.08.03 가입", for: .normal)
        $0.setImage(UIImage(systemName: Text.SystemImage.rightButton), for: .normal)
        $0.tintColor = .movieGray
        $0.configuration = config
    }
    
    let movieBoxLabel = UILabel().then {
        $0.backgroundColor = #colorLiteral(red: 0.3311418841, green: 0.4141414141, blue: 0.2714339831, alpha: 1)
        $0.layer.cornerRadius = 16
        $0.clipsToBounds = true
        $0.font = .systemFont(ofSize: 14, weight: .medium)
        $0.textAlignment = .center
        $0.textColor = .white
    }
    
    init() {
        super.init(frame: .zero)
        layer.cornerRadius = 16
        clipsToBounds = true
    }
}

extension ProfileContainerView {
    override func configureHierarchy() {
        [
            nicknameLabel, button,
            movieBoxLabel,
        ].forEach {
            addSubview($0)
        }
    }
    
    override func configureLayout() {
        nicknameLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.centerY.equalTo(button)
        }
        
        button.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(44)
        }
        
        movieBoxLabel.snp.makeConstraints {
            $0.top.equalTo(button.snp.bottom).offset(8)
            $0.horizontalEdges.bottom.equalToSuperview().inset(16)
            $0.height.equalTo(44)
        }
    }
    
    override func configureView() {
        backgroundColor = #colorLiteral(red: 0.2070707071, green: 0.2070707071, blue: 0.2070707071, alpha: 1)
    }
}
