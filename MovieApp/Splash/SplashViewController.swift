//
//  SplashViewController.swift
//  MovieApp
//
//  Created by YoungJin on 7/31/25.
//

import UIKit
import Then
import SnapKit

final class SplashViewController: BaseViewController {

    private let imageView = UIImageView().then {
        $0.image = .splash
        $0.contentMode = .scaleAspectFill
    }
    
    private let appNameLabel = UILabel().then {
        $0.text = Text.appName
        $0.textColor = .white
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 28, weight: .medium)
    }
    
    private let nameLabel = UILabel().then {
        $0.text = Text.myName
        $0.textColor = .white
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 16)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureView()
    }
}

extension SplashViewController: ConfigureUI {
    func configureHierarchy() {
        [
            imageView,
            appNameLabel,
            nameLabel,
        ].forEach {
            view.addSubview($0)
        }
    }
    
    func configureLayout() {
        
        imageView.snp.makeConstraints {
            $0.size.equalTo(240)
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-80)
        }
        
        appNameLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(64)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(appNameLabel.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
    }
    
    func configureView() {
        view.backgroundColor = .black
    }
}
