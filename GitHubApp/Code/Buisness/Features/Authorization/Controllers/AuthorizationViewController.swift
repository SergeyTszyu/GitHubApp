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
          if error != nil {
            // Handle error.
          }
          if credential != nil {
            Auth.auth().signIn(with: credential!) { authResult, error in
              if error != nil {
                // Handle error.
              }
              // User is signed in.
              // IdP data available in authResult.additionalUserInfo.profile.
                
                guard let oauthCredential = authResult?.credential as? OAuthCredential else { return }
              // GitHub OAuth access token can also be retrieved by:
              // oauthCredential.accessToken
              // GitHub OAuth ID token can be retrieved by calling:
              // oauthCredential.idToken
            }
          }
        }
    }
}
