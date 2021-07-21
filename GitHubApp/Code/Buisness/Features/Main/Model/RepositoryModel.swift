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
    var name: String!
    var fullName: String!
    var owner: RepositoryOwnerModel!
    var forks: Int!
    var watchers: Int!
    var issues: Int!
    var stars: Int!
    var programmingLanguage: String!
    var repoDescription: String!
    var created: Date!
    var lastUpdate: Date!
    var urlString: String!
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        
        let dateFormatter = DateFormatter.ISO8601DateFormatter
        let dateTransform = DateFormatterTransform(dateFormatter: dateFormatter)
        
        id                    <- map["id"]
        name                  <- map["name"]
        fullName              <- map["full_name"]
        owner                 <- map["owner"]
        forks                 <- map["forks_count"]
        watchers              <- map["watchers_count"]
        issues                <- map["open_issues_count"]
        programmingLanguage   <- map["language"]
        repoDescription       <- map["description"]
        created               <- (map["created_at"], dateTransform)
        lastUpdate            <- (map["updated_at"], dateTransform)
        urlString             <- map["html_url"]
        stars                 <- map["stargazers_count"]
    }
    
}
