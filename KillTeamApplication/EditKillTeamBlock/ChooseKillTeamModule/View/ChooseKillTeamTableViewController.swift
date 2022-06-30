//
//  ChooseKillTeamTableViewController.swift
//  KillTeamApplication
//
//  Created by Apple on 19.02.2022.
//

import UIKit

class ChooseKillTeamTableViewController: UITableViewController, ChooseKillTeamViewProtocol {

    var presenter: ChooseKillTeamPresenterProtocol?
    
    private let searchBar = UISearchBar()
    private var isSearching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ColorScheme.shared.theme.viewControllerBackground
        tableView.register(ChooseKillTeamCell.self, forCellReuseIdentifier: KillTeamTableViewCell.ChooseKillTeamCell.rawValue)
        configureSearchBar()
    }
    
    private func configureSearchBar() {
        searchBar.sizeToFit()
        tableView.tableHeaderView = searchBar
        searchBar.placeholder = "Search Kill Team"
        searchBar.delegate = self
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        guard let model = presenter?.model else { return 0 }
        if isSearching {
            return 1
        } else {
            return model.allFaction.count
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let model = presenter?.model else { return 0 }
        if isSearching {
            return model.filteredArrayOfKillTeam.count
        } else {
            return model.allFaction[section].killTeam.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let model = presenter?.model,
              let cell = tableView.dequeueReusableCell(withIdentifier: KillTeamTableViewCell.ChooseKillTeamCell.rawValue, for: indexPath) as? ChooseKillTeamCell else { return UITableViewCell() }
        var killTeam: KillTeam
        if isSearching {
            killTeam = model.filteredArrayOfKillTeam[indexPath.row]
        } else {
            killTeam = model.allFaction[indexPath.section].killTeam[indexPath.row]
        }
        cell.setupText(killTeam: killTeam)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let model = presenter?.model else { return nil }
        if isSearching {
            if model.filteredArrayOfKillTeam.isEmpty {
                return "No matches found"
            } else {
                return "Found Kill Team"
            }
        } else {
            return model.allFaction[section].name
        }
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constant.Size.killTeamCellHeight
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let model = presenter?.model else { return }
        var killTeam: KillTeam
        if isSearching {
            killTeam = model.filteredArrayOfKillTeam[indexPath.row]
        } else {
            killTeam = model.allFaction[indexPath.section].killTeam[indexPath.row]
        }
        self.dismiss(animated: true, completion: nil)
        killTeam.addDefaultFireTeam()
        presenter?.goToEditKillTeamViewController(killTeam: killTeam)
    }
    
}

//MARK: - Search Bar Delegate

extension ChooseKillTeamTableViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        isSearching = searchText.isEmpty ? false : true
        let str = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        presenter?.filterContent(searchText: str)
        tableView.reloadData()
    }
    
}

