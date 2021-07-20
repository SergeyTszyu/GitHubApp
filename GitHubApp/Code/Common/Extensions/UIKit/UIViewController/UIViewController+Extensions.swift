//
//  UIViewController+Extensions.swift
//  GitHubApp
//
//  Created by Sergey Tszyu on 20.07.2021.
//

import UIKit

extension UIViewController {
    
    func addCloseLeftBarButtonItem(
        target: Any? = self,
        action: Selector? = #selector(UIViewController.dismissAction)) {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(),
            style: .plain,
            target: target,
            action: action)
    }

    func addPopLeftBarButtonItem() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(), // back
            style: .plain,
            target: self,
            action: #selector(UIViewController.popAction))
    }

    @objc func popAction() {
        popController()
    }

    @objc func dismissAction() {
        dismissController()
    }

}

extension UIViewController {
    
    func dismissController(animated: Bool = true) {
        dismiss(animated: animated)
    }
    
    func popController(animated: Bool = true) {
        navigationController?.popViewController(animated: animated)
    }
    
}
