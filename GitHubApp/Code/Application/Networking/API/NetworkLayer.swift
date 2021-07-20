//
//  NetworkLayer.swift
//  GitHubApp
//
//  Created by Sergey Tszyu on 20.07.2021.
//

import Foundation
import Moya
import Alamofire

// MARK: - Protocol

protocol LayerType {
    associatedtype Target: TargetType
    var provider: MoyaProvider<Target> { get }
}

// MARK: - NetworkLayer

struct NetworkLayer<Target: TargetType>: LayerType {
    
    let provider: MoyaProvider<Target>
    
    static func layer() -> NetworkLayer {
        let plugins: [PluginType] = [ErrorHandlerPlugin()]
        let provider = MoyaProvider<Target>(
            manager: manager,
            plugins: plugins)
        return NetworkLayer(provider: provider)
    }
    
}

// MARK: - NetworkAuthorizedLayer

struct NetworkAuthorizedLayer: LayerType {
    
    let provider: MoyaProvider<MultiTarget>
    
    static func layer(token: String) -> NetworkAuthorizedLayer {
        let plugins: [PluginType] = [
            ErrorHandlerPlugin(),
            AuthPlugin(token: token)
        ]
        let provider = MoyaProvider<MultiTarget>(
            manager: manager,
            plugins: plugins)
        return NetworkAuthorizedLayer(provider: provider)
    }
    
}

// MARK: - Request

extension LayerType {

    @discardableResult
    func request(target: Target, completion: @escaping Moya.Completion) -> Cancellable {
        return self.provider.request(target, completion: completion)
    }
    
}

// MARK: - Multi Target

extension NetworkAuthorizedLayer {
    
    @discardableResult
    func request(target: TargetType, completion: @escaping Moya.Completion) -> Cancellable {
        return self.provider.request(MultiTarget(target), completion: completion)
    }
    
}

// MARK: - Configuration

extension LayerType {
    
    static var manager: Manager {
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .reloadIgnoringCacheData
        let manager = Manager(configuration: configuration)
        return manager
    }
    
}
