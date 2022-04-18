//
//  ChooseKillTeamTableViewController.swift
//  KillTeamApplication
//
//  Created by Apple on 19.02.2022.
//

import UIKit

class ChooseKillTeamTableViewController: UITableViewController, ChooseKillTeamViewProtocol {

    var presenter: ChooseKillTeamPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ColorScheme.shared.theme.viewControllerBackground
        tableView.register(ChooseKillTeamCell.self, forCellReuseIdentifier: KillTeamTableViewCell.ChooseKillTeamCell.rawValue)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return presenter!.model.allFaction.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter!.model.allFaction[section].killTeam.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: KillTeamTableViewCell.ChooseKillTeamCell.rawValue, for: indexPath) as! ChooseKillTeamCell
        guard let killTeam = presenter?.model.allFaction[indexPath.section].killTeam[indexPath.row] else { return cell }
        cell.setupText(killTeam: killTeam)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return presenter?.model.allFaction[section].name
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constant.Size.killTeamCellHeight
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard var killTeam = (presenter?.model.allFaction[indexPath.section].killTeam[indexPath.row]) else { return }
        killTeam.prepareKillTeam()
        self.dismiss(animated: true, completion: nil)
        presenter?.goToEditKillTeamViewController(killTeam: killTeam)
    }
}


