//
//  ChooseLoadedKillTeamController.swift
//  KillTeamApplication
//
//  Created by Apple on 19.02.2022.
//

import UIKit

class ChooseLoadedKillTeamController: UITableViewController, ChooseLoadedKillTeamControllerProtocol {
    
    var presenter: ChooseLoadedKillTeamPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        tableView.register(ChooseLoadedKillTeamCell.self, forCellReuseIdentifier: ChooseLoadedKillTeamCell.identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.model.loadedKillTeam.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ChooseLoadedKillTeamCell.identifier, for: indexPath) as! ChooseLoadedKillTeamCell
        let killTeam = presenter?.model.loadedKillTeam[indexPath.row]
        if let userName = killTeam?.userCustomName {
            cell.textLabel?.text = userName
            cell.detailTextLabel?.text = killTeam?.killTeamName
        } else {
            cell.textLabel?.text = killTeam?.killTeamName
            cell.detailTextLabel?.text = killTeam?.factionName
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "My Kill Team"
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let killTeam = presenter?.model.loadedKillTeam[indexPath.row] {
            self.dismiss(animated: true, completion: nil)
            presenter?.chooseKillTeam(killTeam: killTeam)
        }
    }
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let removeKillTeamAction = presenter?.removeKillTeamSwipeAction(indexPath: indexPath, view: self)
        return UISwipeActionsConfiguration(actions: [removeKillTeamAction!])
    }
}
