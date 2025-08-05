//
//  NicknameViewController.swift
//  MovieApp
//
//  Created by YoungJin on 8/2/25.
//

import UIKit
import Toast

final class NicknameViewController: BaseViewController {
    
    var type: NicknameType
    
    private lazy var nicknameView = NicknameView(type: type)
    
    var validate: NicknameValidate?
    
    var nickNameUpdateClosure: (() -> Void)?
    
    init(type: NicknameType) {
        self.type = type
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        view = nicknameView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupButton()
    }
    
    override func setupNaviBar() {
        super.setupNaviBar()
        switch type {
        case .new:
            navigationItem.title = Text.Title.nickname
            navigationController?.navigationBar.isHidden = false
            navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonTapped))
        case .edit:
            navigationItem.title = Text.Title.editNmae
            navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(exitButtonTapped))
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(completeButtonTapped))
        }
    }
    
    private func setupButton() {
        nicknameView.editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        nicknameView.completeButton.addTarget(self, action: #selector(completeButtonTapped), for: .touchUpInside)
    }
    
    @objc private func backButtonTapped() {
           nicknameView.nicknameLabel.text = ""
           navigationController?.popViewController(animated: true)
       }
    
    @objc private func exitButtonTapped() {
           nicknameView.nicknameLabel.text = ""
           dismiss(animated: true)
       }
    
    @objc private func editButtonTapped() {
        let vc = NicknameDetailViewController(type: self.type, nickname: self.nicknameView.nicknameLabel.text)
        vc.nicknameUpdateClosure = { [weak self] nickname, validate in
            self?.nicknameView.nicknameLabel.text = nickname
            self?.validate = validate
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func completeButtonTapped() {
        
        guard let validate else {
            view.makeToast("닉네임을 입력해주세요", position: .top)
            return
        }
        switch validate {
        case .valid:
            guard let nickname = nicknameView.nicknameLabel.text else { return }
            showAlert(title: "닉네임 확인", message: "'\(nickname)'으로 하시겠습니까?", ok: "확인") { [weak self] in
                guard let self else { return }
                /// 유저디폴트 저장
                UserDefaultsManager.shared.saveNickname(nickname)
                UserDefaultsManager.shared.saveJoinDate()
                switch self.type {
                case .new:
                    if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                        let tabBar = TabBarController()
                        
                        sceneDelegate.changeRootViewController(tabBar)
                    }
                case .edit:
                    self.nickNameUpdateClosure?()
                    dismiss(animated: true)
                }
            }
        case .length:
            view.makeToast("닉네임 글자수 확인 필요", position: .top)
        case .specialCharacters:
            view.makeToast("특수문자가 들어있습니다", position: .top)
        case .numbers:
            view.makeToast("숫자가 포함되어 있습니다.", position: .top)
        }
    }
}
