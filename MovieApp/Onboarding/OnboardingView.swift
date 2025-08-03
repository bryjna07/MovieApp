//
//  OnboardingView.swift
//  MovieApp
//
//  Created by YoungJin on 8/2/25.
//

import UIKit
import Then
import SnapKit

final class OnboardingView: BaseView {
    
    private let imageView = UIImageView().then {
        $0.image = .splash
        $0.contentMode = .scaleAspectFill
    }
    
    private let mainLabel = UILabel().then {
        $0.text = Text.onboarding
        $0.textColor = .white
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 28, weight: .medium)
    }
    
    private let explainLabel = UILabel().then {
        $0.text = Text.explain
        $0.textColor = .white
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 16)
        $0.numberOfLines = 0
    }
    
    let startButton = CustomButton(title: Text.ButtonText.start, color: .main, width: 1)
    
}

extension OnboardingView {
    override func configureHierarchy() {
        [
            imageView,
            mainLabel,
            explainLabel,
            startButton
        ].forEach {
            addSubview($0)
        }
    }
    
    override func configureLayout() {
        
        imageView.snp.makeConstraints {
            $0.size.equalTo(240)
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-80)
        }
        
        mainLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(64)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
        
        explainLabel.snp.makeConstraints {
            $0.top.equalTo(mainLabel.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
        
        startButton.snp.makeConstraints {
            $0.top.equalTo(explainLabel.snp.bottom).offset(40)
            $0.height.equalTo(44)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
    }
    
    override func configureView() {
        super.configureView()
    }
}
