//
//  Session.swift
//  GitHubApp
//
//  Created by Sergey Tszyu on 20.07.2021.
//

import Foundation

// MARK: - Constans

fileprivate struct SessionKeys {
    static let token = "token"
}

class Session: NSObject, Codable, NSSecureCoding {
    
    static var supportsSecureCoding: Bool {
        get {
            return true
        }
    }
    
    // MARK: - Properties
    
    let token: String
    
    // MARK: - Life cycle
    
    init(token: String) {
        self.token = token
    }
    
    convenience init(plainObject: SessionPlainObject) {
        self.init(token: plainObject.token)
    }
    
    // MARK: - NSCoding
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        guard let token = aDecoder.decodeString(with: SessionKeys.token) else {
            return nil
        }
        self.init(token: token)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(token, forKey: SessionKeys.token)
    }
    
}
