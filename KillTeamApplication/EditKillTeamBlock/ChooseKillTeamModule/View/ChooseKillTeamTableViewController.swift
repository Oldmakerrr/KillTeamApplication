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
        tableView.register(ChooseKillTeamTableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    private func generateKey(name: String) -> String {
        var key = ""
        let random2 = Int.random(in: 0...100000)
        key += String(random2)
        key += name
        let random = Int.random(in: 0...100000)
        key += String(random)
        return key
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return presenter!.model.allFaction.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter!.model.allFaction[section].killTeam.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let KillTeam = presenter?.model.allFaction[indexPath.section].killTeam[indexPath.row]
        cell.imageView?.image = UIImage(named: KillTeam!.factionLogo)
        cell.textLabel?.text = KillTeam?.killTeamName
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return presenter?.model.allFaction[section].name
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var killTeam = (presenter?.model.allFaction[indexPath.section].killTeam[indexPath.row])!
        killTeam.id = generateKey(name: killTeam.killTeamName)
        self.dismiss(animated: true, completion: nil)
        presenter?.goToEditKillTeamViewController(killTeam: killTeam)
    }
}


