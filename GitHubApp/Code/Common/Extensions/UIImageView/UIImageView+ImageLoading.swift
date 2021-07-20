//
//  UIImageView+ImageLoading.swift
//  GitHubApp
//
//  Created by Sergey Tszyu on 20.07.2021.
//

import UIKit
import SDWebImage

extension UIImageView {
    
    func cancelImageLoading() {
        sd_cancelCurrentImageLoad()
    }
    
    func setImageWithURL(_ url: URL?, placeholder: UIImage? = nil) {
        
        if image == nil {
            image = placeholder
        }
        
        guard let url = url else {
            return
        }
        
        self.sd_setImage(with: url, placeholderImage: placeholder)
    }
}
