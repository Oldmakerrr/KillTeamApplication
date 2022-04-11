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
        view.backgroundColor = UIColor.gray
        tableView.register(ChooseKillTeamTableViewCell.self, forCellReuseIdentifier: KillTeamTableViewCell.ChooseKillTeamTableViewCell.rawValue)
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return presenter!.model.allFaction.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter!.model.allFaction[section].killTeam.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: KillTeamTableViewCell.ChooseKillTeamTableViewCell.rawValue, for: indexPath) as! ChooseKillTeamTableViewCell
        guard let killTeam = presenter?.model.allFaction[indexPath.section].killTeam[indexPath.row] else { return cell }
        cell.setupText(killTeam: killTeam)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return presenter?.model.allFaction[section].name
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard var killTeam = (presenter?.model.allFaction[indexPath.section].killTeam[indexPath.row]) else { return }
        let uuid = UUID().uuidString
        killTeam.id = uuid
        killTeam.counterFT = [:]
        self.dismiss(animated: true, completion: nil)
        presenter?.goToEditKillTeamViewController(killTeam: killTeam)
    }
}


