//
//  ErrorHandlerPlugin.swift
//  GitHubApp
//
//  Created by Sergey Tszyu on 20.07.2021.
//

import Moya
import Result
import Moya_ObjectMapper

struct ErrorHandlerPlugin: PluginType {
    
    func process(_ result: Result<Response, MoyaError>, target: TargetType) -> Result<Response, MoyaError> {
        
        if case .success(var response) = result {
            do {
                response = try response.filterSuccessfulStatusCodes()
            } catch var error {
                let moyaError = MoyaError.underlying(error, response)
                return Result.failure(moyaError)
            }
        }
        return result
    }
    
}
