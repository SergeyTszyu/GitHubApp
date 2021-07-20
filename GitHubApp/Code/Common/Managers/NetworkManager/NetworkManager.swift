//
//  NetworkManager.swift
//  GitHubApp
//
//  Created by Sergey Tszyu on 20.07.2021.
//

import Foundation
import Moya
import Result
import Alamofire

class NetworkManager {

    // MARK: -
    
    typealias Completion<T> = (T?, Error?) -> Void
    
    // MARK: -
    
    static let shared = NetworkManager()
    
    var sessionProvider = SessionProvider()
    
    // MARK: - Layers
    
    var authorizedLayer: NetworkAuthorizedLayer?
    
    // MARK: -
    
    var deviceToken: String?
    
    lazy var session: Session? = {
        return sessionProvider.getSession()
    }()

    var authorized: Bool {
        return session != nil
    }
    
    // MARK: - Init
    
    init() {
        if let token = session?.token {
            authorizedLayer = NetworkAuthorizedLayer.layer(token: token)
        }
    }
    
}

// MARK: - Private

private extension  NetworkManager {
    
    func saveSession(_ session: Session) {
        self.session = session
        sessionProvider.saveSession(session)
        updateAuthorizedLayer()
    }
    
    func updateAuthorizedLayer() {
        if let token = session?.token {
            authorizedLayer = NetworkAuthorizedLayer.layer(token: token)
        }
    }

}

extension NetworkManager {

    func authorizedRequest(
        target: TargetType,
        completion: @escaping Moya.Completion) {
        self.authorizedLayer?.request(target: target, completion: completion)
    }
}

func authorizedRequest(
    target: TargetType,
    completion: @escaping Moya.Completion) {
    let manager = NetworkManager.shared
    manager.authorizedLayer?.request(target: target, completion: completion)
}
