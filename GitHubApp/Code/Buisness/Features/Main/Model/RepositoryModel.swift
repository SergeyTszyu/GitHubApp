//
//  RepositoryModel.swift
//  GitHubApp
//
//  Created by Sergey Tszyu on 21.07.2021.
//

import Foundation
import ObjectMapper

struct RepositoryModel: Mappable {
    
    var id: Int!
    var fullName: String!
    var owner: RepositoryOwnerModel!
    
    var forks: Int!
    var watchers: Int!
    var issues: Int!
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        id                    <- map["id"]
        fullName              <- map["full_name"]
        owner                 <- map["owner"]
        forks                 <- map["forks_count"]
        watchers              <- map["watchers_count"]
        issues                <- map["open_issues_count"]
    }
    
}
