//
//  RepositoryInfoViewController.swift
//  GitHubApp
//
//  Created by Sergey Tszyu on 21.07.2021.
//

import UIKit

final class RepositoryInfoViewController: UIViewController {
    
    // MARK: - @IBOutlets
    
    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var userNameLabel: UILabel!
    @IBOutlet private weak var createdLabel: UILabel!
    @IBOutlet private weak var repositoriesLabel: UILabel!
    @IBOutlet private weak var repositoryDescriptionLabel: UILabel!
    @IBOutlet private weak var repositoryLanguageLabel: UILabel!
    @IBOutlet private weak var repositoryCreatedLabel: UILabel!
    @IBOutlet private weak var repositoryUpdatedLabel: UILabel!
    
    // MARK: - Properties
    
    fileprivate var userModel: RepositoryOwnerModel!
    fileprivate var repositoryModel: RepositoryModel!
    
    fileprivate var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return dateFormatter
    }()
    
    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
}

// MARK: - Public

extension RepositoryInfoViewController {
    
    func fill(_ userModel: RepositoryOwnerModel, repositoryModel: RepositoryModel) {
        self.userModel = userModel
        self.repositoryModel = repositoryModel
    }
}

// MARK: - Private

private extension RepositoryInfoViewController {
    
    func configure() {
        if let avatarURL = URL(string: userModel.avatarUrlString) {
            avatarImageView.setImageWithURL(avatarURL)
        }
        userNameLabel.text = userModel.login
        let createdUser = dateFormatter.string(from: userModel.created)
        createdLabel.text = "Created: \(createdUser)"
        repositoriesLabel.text = "Public repositories: \(userModel.publicRepositories ?? 0)"
        
        repositoryDescriptionLabel.text = repositoryModel.repoDescription
        repositoryLanguageLabel.text = "Language: \(repositoryModel.programmingLanguage ?? "")"
        
        let createdRepo = dateFormatter.string(from: repositoryModel.created)
        repositoryCreatedLabel.text = "Created repository: \(createdRepo)"
        
        let lastUpdate = dateFormatter.string(from: repositoryModel.lastUpdate)
        repositoryUpdatedLabel.text = "Last update: \(lastUpdate)"
    }
    
    @IBAction func openLinkAction(_ sender: UIButton) {
        if let url = URL(string: repositoryModel.urlString) {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func openUserInfo(_ sender: UIButton) {
        let userInfoController = R.storyboard.userInfo.userInfoViewController()!
        userInfoController.fill(userModel, repositoryModel: repositoryModel)
        self.navigationController?.pushViewController(userInfoController, animated: true)
    }
}
