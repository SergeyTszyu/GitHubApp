//
//  ProgressHUD.swift
//  GitHubApp
//
//  Created by Sergey Tszyu on 20.07.2021.
//

import Foundation
import SVProgressHUD

final class ProgressHUD: SVProgressHUD {

    override class func show() {
        DispatchQueue.main.async {
            super.show()
        }
    }
    
    override class func dismiss() {
        DispatchQueue.main.async {
            super.dismiss()
        }
    }

}

extension ProgressHUD {
    
    static func customizeAppearance() {
        SVProgressHUD.setForegroundColor(.blue)
        SVProgressHUD.setBackgroundColor(.white)
        SVProgressHUD.setDefaultMaskType(.clear)
    }
}
