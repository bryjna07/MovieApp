//
//  SearchView.swift
//  MovieApp
//
//  Created by YoungJin on 8/3/25.
//

import UIKit
import Then
import SnapKit

final class SearchView: BaseView {
    
    let searchBar = UISearchBar().then {
        $0.placeholder = "영화를 검색해보세요"
        $0.searchTextField.attributedPlaceholder = NSAttributedString(string: $0.searchTextField.placeholder ?? "", attributes: [.foregroundColor : UIColor.systemGray3]) // 플레이스홀더 색상
        $0.barTintColor = .black // 서치바 배경색
        $0.searchTextField.backgroundColor = .darkGray // 서치 텍필 색상
        $0.searchTextField.leftView?.tintColor = .white // 서치 아이콘 색상
        $0.tintColor = .white // 커서 색상
        $0.searchTextField.font = .systemFont(ofSize: 16)
        $0.searchTextField.textColor = .white // 입력 색상
    }
    
}


extension SearchView {
    override func configureHierarchy() {
        [
            searchBar,
        ].forEach {
            addSubview($0)
        }
    }
    
    override func configureLayout() {
        searchBar.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
        }
        
        
    }
}

