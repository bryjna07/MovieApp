//
//  SceneDelegate.swift
//  MovieApp
//
//  Created by YoungJin on 7/31/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        window?.rootViewController = SplashViewController()
        window?.makeKeyAndVisible()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            
            let vc = OnboardingViewController()
            let naviVC = UINavigationController(rootViewController: vc)
            
            self.window?.rootViewController = naviVC
        }
    }
}

