//
//  RepositoryNetworkManager.swift
//  GitHubApp
//
//  Created by Sergey Tszyu on 21.07.2021.
//

import Foundation
import Moya
import ObjectMapper

final class RepositoryNetworkManager {
    
    typealias Completion<T> = (T?, Error?) -> Void
    
    static let shared = RepositoryNetworkManager()
    
    // MARK: - List repositories
    
    func repositoriesBy(_ name: String, _ completion: Completion<[RepositoryModel]>?) {
        let target = RepositoryAPI.repositoriesBy(name)
        authorizedRequest(target: target) { result in
            switch result {
            case .success(let response):
                let cities = try? response.mapArray(RepositoryModel.self, atKeyPath: "items")
                completion?(cities, nil)
            case .failure(let error):
                completion?(nil, error)
            }
        }
    }
    
    func userBy(_ userName: String, _ completion: Completion<RepositoryOwnerModel>?) {
        let target = RepositoryAPI.userBy(userName)
        authorizedRequest(target: target) { result in
            switch result {
            case .success(let response):
                do {
                    let user = try response.mapObject(RepositoryOwnerModel.self)
                    completion?(user, nil)
                } catch let error {
                    completion?(nil, error)
                }
            case .failure(let error):
                completion?(nil, error)
            }
        }
    }
    
}
