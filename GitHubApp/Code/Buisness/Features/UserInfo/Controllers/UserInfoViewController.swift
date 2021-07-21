//
//  UserInfoViewController.swift
//  GitHubApp
//
//  Created by Sergey Tszyu on 21.07.2021.
//

import UIKit

final class UserInfoViewController: UIViewController {
    
    // MARK: - @IBOutlets
    
    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var userNameLabel: UILabel!
    @IBOutlet private weak var bioLabel: UILabel!
    @IBOutlet private weak var locationLabel: UILabel!
    @IBOutlet private weak var followersLabel: UILabel!
    @IBOutlet private weak var followingLabel: UILabel!
    
    // MARK: - Properties
    
    fileprivate var userModel: RepositoryOwnerModel!
    fileprivate var repositoryModel: RepositoryModel!
    
    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
}

// MARK: - Public

extension UserInfoViewController {
    
    func fill(_ userModel: RepositoryOwnerModel, repositoryModel: RepositoryModel) {
        self.userModel = userModel
        self.repositoryModel = repositoryModel
    }
}

// MARK: - Private

private extension UserInfoViewController {
    
    func configure() {
        if let avatarURL = URL(string: userModel.avatarUrlString) {
            avatarImageView.setImageWithURL(avatarURL)
        }
        userNameLabel.text = userModel.login
        bioLabel.text = "bio: \(userModel.bio ?? "-")"
        locationLabel.text = "location: \(userModel.location ?? "-")"
        followersLabel.text = "\(userModel.followers ?? 0) followers"
        followingLabel.text = "\(userModel.following ?? 0) following"
    }
    
    @IBAction func openLinkAction(_ sender: UIButton) {
        if let url = URL(string: userModel.urlString) {
            UIApplication.shared.open(url)
        }
    }
}
