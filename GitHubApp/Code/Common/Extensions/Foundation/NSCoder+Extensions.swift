//
//  NSCoder+Extensions.swift
//  GitHubApp
//
//  Created by Sergey Tszyu on 20.07.2021.
//

import Foundation

extension NSCoder {
    
    func decodeString(with key: String) -> String? {
        return decodeObject(forKey: key) as? String
    }
    
    func decodeBool(with key: String) -> Bool? {
        return decodeObject(forKey: key) as? Bool
    }
    
}
