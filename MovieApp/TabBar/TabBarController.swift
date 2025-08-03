//
//  TabBarController.swift
//  MovieApp
//
//  Created by YoungJin on 8/3/25.
//

import UIKit
import SnapKit
import Then


final class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        setupViewControllers()
    }
    
    private func setupViewControllers() {
//        let mainVC =
        let first = UINavigationController(rootViewController: MovieMainViewController()).then {
            $0.tabBarItem = UITabBarItem(
                title: Text.TabBar.firstTitle,
                image: UIImage(systemName: Text.TabBar.firstImage),
                tag: 0
            )
        }
        
        let second = UINavigationController(rootViewController: MovieMainViewController()).then {
            $0.tabBarItem = UITabBarItem(
                title: Text.TabBar.secondTitle,
                image: UIImage(systemName: Text.TabBar.secondImage),
                tag: 1
            )
        }
        
        let third = UINavigationController(rootViewController: MovieMainViewController()).then {
            $0.tabBarItem = UITabBarItem(
                title: Text.TabBar.thirdTitle,
                image: UIImage(systemName: Text.TabBar.thirdImage),
                tag: 2
            )
        }
        
        setViewControllers([first, second, third,], animated: true)
    }
    
    private func setupTabBar() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .black
        
        appearance.stackedLayoutAppearance.selected.iconColor = .main
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.main]
        
        appearance.stackedLayoutAppearance.normal.iconColor = .movieGray
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.movieGray]
        
        UITabBar.appearance().standardAppearance = appearance
    }
}
