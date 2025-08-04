//
//  ReusableViewProtocol.swift
//  MovieApp
//
//  Created by YoungJin on 8/4/25.
//

import UIKit

protocol ReusableViewProtocol {
    static var identifier: String { get }
}

extension UIViewController: ReusableViewProtocol {
    
    static var identifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReusableViewProtocol {
    
    static var identifier: String {
        return String(describing: self)
    }
}

extension UICollectionViewCell: ReusableViewProtocol {
    
    static var identifier: String {
        return String(describing: self)
    }
}
