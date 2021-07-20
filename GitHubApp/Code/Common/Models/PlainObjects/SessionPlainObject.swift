//
//  SessionPlainObject.swift
//  GitHubApp
//
//  Created by Sergey Tszyu on 20.07.2021.
//

import Foundation
import ObjectMapper

struct SessionPlainObject: Mappable {
    
    var token: String!
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        
        token <- map["token"]
    }
    
}
