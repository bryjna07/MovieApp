//
//  OnboardingViewController.swift
//  MovieApp
//
//  Created by YoungJin on 8/2/25.
//

import UIKit

final class OnboardingViewController: BaseViewController {
    
    private let onboardingView = OnboardingView()
    
    override func loadView() {
        view = onboardingView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtonAction()
        navigationController?.navigationBar.isHidden = true
    }
    
    private func setupButtonAction() {
        onboardingView.startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
    }
    
    @objc private func startButtonTapped() {
        let vc = NicknameViewController()
        
        navigationController?.pushViewController(vc, animated: true)
    }
}
