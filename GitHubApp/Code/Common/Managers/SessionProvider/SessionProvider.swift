//
//  SessionProvider.swift
//  GitHubApp
//
//  Created by Sergey Tszyu on 20.07.2021.
//

import Foundation

struct SessionProvider {

    // MARK: - Properties
    
    static private let SessionKey = "SessionKey"
    
    // MARK: - Variables
    
    let defaults: UserDefaults
    
    // MARK: - Lifecycle
    
    init(defaults: UserDefaults) {
        self.defaults = defaults
    }
    
    init() {
        self.defaults = UserDefaults.standard
    }

    // MARK: - Public
    
    mutating func dropSession() {
        defaults.removeObject(forKey: SessionProvider.SessionKey)
        defaults.synchronize()
    }
    
    mutating func saveSession(_ session: Session) {
        do {
            let userData = try NSKeyedArchiver.archivedData(withRootObject: session as Session, requiringSecureCoding: false)
            defaults.set(userData, forKey: SessionProvider.SessionKey)
            defaults.synchronize()
        } catch {
            print("Error saveSession")
        }
    }
    
    func getSession() -> Session? {
        if let data = defaults.object(forKey: SessionProvider.SessionKey) as? Data {
            do {
                let userData = try NSKeyedUnarchiver.unarchivedObject(ofClass: Session.self, from: data)
                return userData
            } catch {
                print("Error getSession")
            }
        }
        return nil
    }
}
