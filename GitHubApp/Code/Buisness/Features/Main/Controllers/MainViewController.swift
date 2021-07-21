//
//  MainViewController.swift
//  GitHubApp
//
//  Created by Sergey Tszyu on 20.07.2021.
//

import UIKit

fileprivate enum FilterType: Int {
    case stars
    case forks
    case updated
    
    var title: String {
        switch self {
        case .stars:
            return "Stars"
        case .forks:
            return "Forks"
        case .updated:
            return "Updated"
        }
    }
    
    static func filterData() -> [FilterType] {
        return [.stars, .forks, .updated]
    }
}

final class MainViewController: UIViewController {
    
    // MARK: - @IBOutlets
    
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Properties
    
    fileprivate let searchController = UISearchController(searchResultsController: nil)
    
    fileprivate var repositories = [RepositoryModel]() {
        didSet {
            tableView.reloadData()
        }
    }
    fileprivate var filteredRepositories = [RepositoryModel]() {
        didSet {
            tableView.reloadData()
        }
    }
    fileprivate var selectedRepository: RepositoryModel!
    fileprivate var filterType: FilterType = .stars {
        didSet {
            filterData()
        }
    }
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        searchRepositoriesWith("cities")
    }
}

// MARK: - Private

private extension MainViewController {
    
    func configure() {
        tableView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0)
        tableView.register(R.nib.repositoryListCell)
        configureSearchController()
    }
    
    func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.isActive = true
        
        searchController.searchBar.scopeButtonTitles = FilterType.filterData().map { $0.title }
        searchController.searchBar.delegate = self
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func searchRepositoriesWith(_ name: String) {
        ProgressHUD.show()
        RepositoryNetworkManager.shared.repositoriesBy(name) { result, error in
            ProgressHUD.dismiss()
            if let repositories = result {
                self.repositories = repositories.sorted { $0.stars > $1.stars }
                self.filteredRepositories = self.repositories
            } else if let error = error {
                Alert.presentAlertView(withType: .error, message: error.localizedDescription)
            }
        }
    }
    
    func openRepositoryInfo() {
        ProgressHUD.show()
        RepositoryNetworkManager.shared.userBy(selectedRepository.owner.login) { userModel, error in
            ProgressHUD.dismiss()
            if let user = userModel {
                let repositoryInfoController = R.storyboard.repositoryInfo.repositoryInfoViewController()!
                repositoryInfoController.fill(user, repositoryModel: self.selectedRepository)
                self.navigationController?.pushViewController(repositoryInfoController, animated: true)
            } else if let error = error {
                Alert.presentAlertView(withType: .error, message: error.localizedDescription)
            }
        }
    }
    
    func openUserInfo() {
        ProgressHUD.show()
        RepositoryNetworkManager.shared.userBy(selectedRepository.owner.login) { userModel, error in
            ProgressHUD.dismiss()
            if let user = userModel {
                let userInfoController = R.storyboard.userInfo.userInfoViewController()!
                userInfoController.fill(user, repositoryModel: self.selectedRepository)
                self.navigationController?.pushViewController(userInfoController, animated: true)
            } else if let error = error {
                Alert.presentAlertView(withType: .error, message: error.localizedDescription)
            }
        }
    }
    
    func filterData() {
        switch filterType {
        case .stars:
            self.repositories = repositories.sorted { $0.stars > $1.stars }
            self.filteredRepositories = self.filteredRepositories.sorted { $0.stars > $1.stars }
        case .forks:
            self.repositories = repositories.sorted { $0.forks > $1.forks }
            self.filteredRepositories = self.filteredRepositories.sorted { $0.forks > $1.forks }
        case .updated:
            self.repositories = repositories.sorted { $0.lastUpdate > $1.lastUpdate }
            self.filteredRepositories = self.filteredRepositories.sorted { $0.lastUpdate > $1.lastUpdate }
        }
    }
}

// MARK: - UITableViewDelegate

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let repositoryData = repositories[indexPath.row]
        self.selectedRepository = repositoryData
        openRepositoryInfo()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64.0
    }
}

// MARK: - UITableViewDataSource

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let listCell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.repositoryListCell, for: indexPath)!
        
        listCell.delegate = self
        let repositoryData = repositories[indexPath.row]
        listCell.fill(repositoryData)
        
        return listCell
    }
}

// MARK: - RepositoryListCellDelegate

extension MainViewController: RepositoryListCellDelegate {
    
    func repositoryListCellTapUser(_ cell: RepositoryListCell) {
        guard let indexPath = tableView.indexPath(for: cell) else {
            return
        }
        let repositoryData = repositories[indexPath.row]
        self.selectedRepository = repositoryData
        openUserInfo()
    }
}

// MARK: - UISearchBarDelegate

extension MainViewController:  UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        guard let filterType = FilterType(rawValue: selectedScope) else {
            return
        }
        self.filterType = filterType
    }
}

// MARK: - UISearchResultsUpdating

extension MainViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            return
        }
    }
}

