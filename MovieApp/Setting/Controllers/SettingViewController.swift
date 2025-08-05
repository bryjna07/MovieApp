//
//  SettingViewController.swift
//  MovieApp
//
//  Created by YoungJin on 8/4/25.
//

import UIKit

class SettingViewController: BaseViewController {
    
    private let settingView = SettingView()
    private let userDefaultsManager = UserDefaultsManager.shared
    
    private let list = ["자주 묻는 질문", "1:1 문의", "알림 설정", "탈퇴하기"]
    
    override func loadView() {
        view = settingView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setProfile()
        setupTableView()
        setupButtonAction()
        updateMovieBox()
    }
    
    override func setupNaviBar() {
        super.setupNaviBar()
        navigationItem.title = "설정"
    }
    
    private func setProfile() {
        if let nickname = UserDefaults.standard.string(forKey: "nickname") {
            settingView.profileView.nicknameLabel.text = nickname
        } else {
            settingView.profileView.nicknameLabel.text = "닉네임 없음"
        }
    }
    
    // 무비박스 갯수 업데이트
    private func updateMovieBox() {
        let likeCount = userDefaultsManager.getlikeCount()
        settingView.profileView.movieBoxLabel.text = "\(likeCount)개의 무비박스 보관중"
    }
    
    private func setupTableView() {
        settingView.tableView.delegate = self
        settingView.tableView.dataSource = self
    }
    
    private func setupButtonAction() {
        settingView.profileView.button.addTarget(self, action: #selector(profileButtonTapped), for: .touchUpInside)
    }
    
    @objc private func profileButtonTapped() {
        let vc = NicknameViewController(type: .edit)
        let naviVC = UINavigationController(rootViewController: vc)
        vc.nickNameUpdateClosure = { [weak self] in
            self?.setProfile()
        }
        present(naviVC, animated: true)
    }
}


extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingCell.identifier, for: indexPath) as? SettingCell else { return UITableViewCell() }
        cell.label.text = list[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.row == 3 else { return }
        showAlert(title: "탈퇴하기", message: "탈퇴를 하면 데이터가 모두 초기화됩니다.\n탈퇴하시겠습니까?", ok: "확인") {
            UserDefaults.standard.removeObject(forKey: "nickname")

            if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                let onboardingVC = OnboardingViewController()
                let naviVC = UINavigationController(rootViewController: onboardingVC)
                
                sceneDelegate.changeRootViewController(naviVC)
            }
            
        }
    }
}
