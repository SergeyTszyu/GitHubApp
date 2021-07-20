//
//  MainViewController.swift
//  GitHubApp
//
//  Created by Sergey Tszyu on 20.07.2021.
//

import UIKit

fileprivate enum FilterType {
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
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        
        ProgressHUD.show()
        RepositoryNetworkManager.shared.repositoriesBy("ios") { result, error in
            ProgressHUD.dismiss()
            if let repositories = result {
                self.repositories = repositories
            } else if let error = error {
                Alert.presentAlertView(withType: .error, message: error.localizedDescription)
            }
        }
    }
}

// MARK: - Private

private extension MainViewController {
    
    func configure() {
        tableView.register(R.nib.repositoryListCell)
        configureSearchController()
    }
    
    func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.isActive = true
        
        searchController.searchBar.scopeButtonTitles = FilterType.filterData().map { $0.title }
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
}

// MARK: - UITableViewDelegate

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72.0
    }
}

// MARK: - UITableViewDataSource

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let listCell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.repositoryListCell, for: indexPath)!
        let repositoryData = repositories[indexPath.row]
        listCell.fill(repositoryData)
        
        return listCell
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

