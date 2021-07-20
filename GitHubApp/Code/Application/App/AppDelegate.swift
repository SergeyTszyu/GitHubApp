//
//  AppDelegate.swift
//  GitHubApp
//
//  Created by Sergey Tszyu on 19.07.2021.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        AppNavigator.setupRootViewController(for: window)
        
        return true
    }

}

