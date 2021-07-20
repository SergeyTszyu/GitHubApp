//
//  AppNavigator.swift
//  GitHubApp
//
//  Created by Sergey Tszyu on 20.07.2021.
//

import UIKit

struct AppNavigator {
    
    static func setupRootViewController(for window: UIWindow?) {
        
        if NetworkManager.shared.authorized {
            window?.rootViewController = R.storyboard.main.instantiateInitialViewController()
        } else {
            window?.rootViewController = R.storyboard.authorization.instantiateInitialViewController()
        }
        
        window?.makeKeyAndVisible()
    }
    
    static func presentMainScreen(animated: Bool = true) {
        setRootViewController(R.storyboard.main.instantiateInitialViewController(), animated: animated)
    }
    
    static func presentLoginScreen(animated: Bool = true) {
        setRootViewController(R.storyboard.authorization.instantiateInitialViewController(), animated: animated)
    }
    
    static func setRootViewController(_ controller: UIViewController?, animated: Bool = true) {
        
        let keyWindow = UIApplication.shared.windows.first { $0.isKeyWindow }
        if let window = keyWindow, let controller = controller {
            window.rootViewController = controller
        }
    }

}
