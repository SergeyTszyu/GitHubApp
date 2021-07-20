//
//  AppNavigator.swift
//  GitHubApp
//
//  Created by Sergey Tszyu on 20.07.2021.
//

import UIKit

struct AppNavigator {
    
    static func setupRootViewController(for window: UIWindow?) {
        
        window?.makeKeyAndVisible()
    }
    
    static func presentMainScreen(animated: Bool = true) {
        
    }
    
    static func presentLoginScreen(animated: Bool = true) {
        
    }
    
    static func setRootViewController(_ controller: UIViewController?, animated: Bool = true) {
        
        if let window = UIApplication.shared.keyWindow, let controller = controller {
            window.rootViewController = controller
        }
    }

}
