//
//  BaseTableViewCell.swift
//  MovieApp
//
//  Created by YoungJin on 8/2/25.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            configureHierarchy()
            configureLayout()
            configureView()
        }
        
        @available(*, unavailable)
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
}

extension BaseTableViewCell: ConfigureUI {
    
    func configureUIWithData() { }
    
    func configureHierarchy() { }
    
    func configureLayout() { }
    
    func configureView() { }
}
