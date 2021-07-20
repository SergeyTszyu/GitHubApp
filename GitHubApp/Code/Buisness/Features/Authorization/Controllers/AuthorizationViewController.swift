//
//  AuthorizationViewController.swift
//  GitHubApp
//
//  Created by Sergey Tszyu on 20.07.2021.
//

import UIKit
import FirebaseAuth

final class AuthorizationViewController: UIViewController {
    
    // MARK: - @IBOutlets
    
    // MARK: - Properties
    
    fileprivate var provider: OAuthProvider?
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

// MARK: - Private

private extension AuthorizationViewController {
    
    @IBAction func sigIn() {
        
        provider = OAuthProvider(providerID: "github.com")
        
        provider!.getCredentialWith(nil) { credential, error in
            if let credential = credential {
                Auth.auth().signIn(with: credential) { result, error in
                    if let resultAuth = result, let oauthCredential = resultAuth.credential as? OAuthCredential {
                        let session = Session(token: oauthCredential.accessToken ?? "")
                        NetworkManager.shared.sessionProvider.saveSession(session)
                    } else if let error = error {
                        Alert.presentAlertView(withType: .error, message: error.localizedDescription)
                    }
                }
            }
        }
    }
}
