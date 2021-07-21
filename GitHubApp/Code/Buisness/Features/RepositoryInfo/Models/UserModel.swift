//
//  UserModel.swift
//  GitHubApp
//
//  Created by Sergey Tszyu on 21.07.2021.
//

import Foundation
import ObjectMapper

struct UserModel: Mappable {
    
    var id: Int!
    var login: String!
    var avatarUrlString: String!
    var created: Date!
    var publicRepositories: Int!
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        id                    <- map["id"]
        login                 <- map["login"]
        avatarUrlString       <- map["avatar_url"]
    }
    
}
