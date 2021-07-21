//
//  RepositoryOwnerModel.swift
//  GitHubApp
//
//  Created by Sergey Tszyu on 21.07.2021.
//

import Foundation
import ObjectMapper

struct RepositoryOwnerModel: Mappable {
    
    var id: Int!
    var login: String!
    var avatarUrlString: String!
    var created: Date!
    var publicRepositories: Int!
    var location: String!
    var bio: String!
    var following: Int!
    var followers: Int!
    var urlString: String!
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        
        let dateFormatter = DateFormatter.ISO8601DateFormatter
        let dateTransform = DateFormatterTransform(dateFormatter: dateFormatter)
        
        id                    <- map["id"]
        login                 <- map["login"]
        avatarUrlString       <- map["avatar_url"]
        created               <- (map["created_at"], dateTransform)
        publicRepositories    <- map["public_repos"]
        location              <- map["location"]
        bio                   <- map["bio"]
        following             <- map["following"]
        followers             <- map["followers"]
        urlString             <- map["html_url"]
    }
    
}
