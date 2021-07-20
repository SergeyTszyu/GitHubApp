//
//  APIProtocolable.swift
//  GitHubApp
//
//  Created by Sergey Tszyu on 20.07.2021.
//

import Foundation

protocol APIProtocolable {
    var baseURL: URL { get }
}

protocol APIAuthorized: APIProtocolable {
}

enum URLType: String {
    case production
    case development
    
    var stringURL: String {
        switch self {
        case .development:
            return "https://api.github.com"
        case .production:
            return "https://api.github.com"
        }
    }
}

extension APIProtocolable {
    
    var baseURL: URL {
        let type: URLType!
        #if !DEBUG || TESTING
            type = .production
        #else
            type = .development
        #endif
        return URL(string: type.stringURL)!
    }
    
}
