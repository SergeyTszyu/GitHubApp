//
//  AuthPlugin.swift
//  GitHubApp
//
//  Created by Sergey Tszyu on 20.07.2021.
//

import Foundation
import Moya

struct AuthPlugin: PluginType {
    
    var token: String
    
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        var request = request
        let tokenString = "Bearer \(token)"
        request.addValue(tokenString, forHTTPHeaderField: "Authorization")
        
        if let body = request.httpBody,
           let str = String(data: body, encoding: .utf8) {
            print("request to send: \(str)")
        }
        
        return request
    }
    
}
