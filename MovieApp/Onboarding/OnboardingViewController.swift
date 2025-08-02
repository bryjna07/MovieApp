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
    }
    
    private func setupButtonAction() {
        onboardingView.startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
    }
    
    @objc private func startButtonTapped() {
        print(#function)
    }
}
