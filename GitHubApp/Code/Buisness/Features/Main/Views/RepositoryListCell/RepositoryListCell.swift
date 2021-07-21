//
//  RepositoryListCell.swift
//  GitHubApp
//
//  Created by Sergey Tszyu on 20.07.2021.
//

import UIKit

protocol RepositoryListCellDelegate: class {
    func repositoryListCellTapUser(_ cell: RepositoryListCell)
}

final class RepositoryListCell: UITableViewCell {
    
    // MARK: - @IBOutlets
    
    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var repositoryNameLabel: UILabel!
    @IBOutlet private weak var ownerNameLabel: UILabel!
    @IBOutlet private weak var forksLabel: UILabel!
    @IBOutlet private weak var watchersLabel: UILabel!
    @IBOutlet private weak var issuesLabel: UILabel!
    
    // MARK: - Properties
    
    weak var delegate: RepositoryListCellDelegate?
    
    // MARK: - Life cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        avatarImageView.image = nil
        repositoryNameLabel.text = nil
        ownerNameLabel.text = nil
        forksLabel.text = nil
        watchersLabel.text = nil
        issuesLabel.text = nil
    }
}

// MARK: - Public

extension RepositoryListCell {
    
    func fill(_ repositoryData: RepositoryModel) {
        
        if let avatarURL = URL(string: repositoryData.owner.avatarUrlString) {
            avatarImageView.setImageWithURL(avatarURL)
        }
        
        repositoryNameLabel.text = repositoryData.name
        ownerNameLabel.text = repositoryData.owner.login
        forksLabel.text = "\(repositoryData.forks ?? 0)"
        watchersLabel.text = "\(repositoryData.watchers ?? 0)"
        issuesLabel.text = "\(repositoryData.issues ?? 0)"
    }
}

// MARK: - Private

private extension RepositoryListCell {
    
    @IBAction func tapUserImage(_ sender: UIButton) {
        delegate?.repositoryListCellTapUser(self)
    }
}
