//
//  Alert.swift
//  GitHubApp
//
//  Created by Sergey Tszyu on 20.07.2021.
//

import UIKit

struct Alert {
    
    enum AlertType {
        
        case success
        case error
        case custom(title: String)
        
        var title: String {
            switch self {
            case .success:
                return ""
            case .error:
                return "Error"
            case .custom(let title):
                return title
            }
        }
    }
    
    static func presentAlertView(withType type: AlertType, message: String?, actions: [UIAlertAction]? = nil, from controller: UIViewController? = UIApplication.topViewController()) {
        
        let alert = UIAlertController(title: type.title, message: message ?? "", preferredStyle: .alert)
        
        if let actions = actions, actions.count > 0 {
            
            for action in actions {
                alert.addAction(action)
            }
            
        } else {
            let okAction = UIAlertAction(title: "OK",
                                         style: .default,
                                         handler: nil)
            alert.addAction(okAction)
        }
        
        controller?.present(alert, animated: true, completion: nil)
    }
}
