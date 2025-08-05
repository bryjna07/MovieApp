//
//  NicknameDetailViewController.swift
//  MovieApp
//
//  Created by YoungJin on 8/2/25.
//

import UIKit

final class NicknameDetailViewController: BaseViewController {
    
    var type: NicknameType
    
    lazy var detailView = NicknameDetailView()
    
    var nicknameUpdateClosure: ((String, NicknameValidate?) -> Void)?
    
    init(type: NicknameType, nickname: String? = nil) {
        self.type = type
        super.init(nibName: nil, bundle: nil)
        self.detailView.textField.text = nickname
    }
    
    override func loadView() {
        view = detailView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        detailView.textField.becomeFirstResponder()
        detailView.textField.delegate = self
    }
    
    override func setupNaviBar() {
        super.setupNaviBar()
        switch type {
        case .new:
            navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonTapped))
            navigationItem.title = Text.Title.nickname
        case .edit:
            navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonTapped))
            navigationItem.title = Text.Title.editNmae
        }
    }
    
    @objc private func backButtonTapped() {
           let nickname = detailView.textField.text ?? ""
           let validate = NicknameValidate(rawValue: detailView.validLabel.text ?? "")
           nicknameUpdateClosure?(nickname, validate)
           navigationController?.popViewController(animated: true)
       }
}

extension NicknameDetailViewController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        let nickname = textField.text ?? ""
        detailView.validLabel.text = validateNickname(nickname).rawValue
    }
    
    private func validateNickname(_ nickname: String) -> NicknameValidate {
        guard nickname.count >= 2 && nickname.count < 10 else { return .length }

        if nickname.rangeOfCharacter(from: CharacterSet(charactersIn: "@#$%")) != nil {
            return .specialCharacters
        }

        if nickname.rangeOfCharacter(from: .decimalDigits) != nil {
            return .numbers
        }

        return .valid
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}
