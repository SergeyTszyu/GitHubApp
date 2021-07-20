//
//  BaseViewController.swift
//  GitHubApp
//
//  Created by Sergey Tszyu on 20.07.2021.
//

import UIKit

class BaseViewController: UIViewController {
    
    var isDarkStatusBar = true {
        didSet {
            self.setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if hidesBottomBarWhenPushed {
            tabBarController?.tabBar.isHidden = true
        }
        
        if navigationController != nil {
            navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
        
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.isTranslucent = false
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var shouldAutomaticallyForwardAppearanceMethods: Bool {
        return true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return isDarkStatusBar ? .default : .lightContent
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .portrait
    }

    @IBAction func close() {
        
        if let presentingViewController = navigationController?.presentingViewController {
            presentingViewController.dismiss(animated: true, completion: nil)
        } else if let presentingViewController = presentingViewController {
            presentingViewController.dismiss(animated: true, completion: nil)
        } else if let navigationController = navigationController {
            navigationController.popViewController(animated: true)
        }
    }
    
}
