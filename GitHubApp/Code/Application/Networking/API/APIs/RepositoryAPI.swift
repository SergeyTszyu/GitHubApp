//
//  RepositoryAPI.swift
//  GitHubApp
//
//  Created by Sergey Tszyu on 20.07.2021.
//

import Moya
import Alamofire

enum RepositoryAPI: APIProtocolable {
    
    case repositoriesBy(_ name: String)
    case userBy(_ userName: String)
}

extension RepositoryAPI: TargetType {
    
    var headers: [String: String]? {
        return nil
    }
    
    var path: String {
        switch self {
        case .repositoriesBy(_):
            return "/search/repositories"
        case .userBy(let userName):
            return "/users/\(userName)"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var parameterEncoding: ParameterEncoding {
        return JSONEncoding.default
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .repositoriesBy(let name):
            return .requestParameters(parameters: ["q": name],
                                      encoding: URLEncoding.default)
        case .userBy(_):
            return .requestPlain
        }
    }
    
}
