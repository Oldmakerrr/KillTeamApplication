//
//  RosterTableViewController.swift
//  KillTeamApplication
//
//  Created by Apple on 19.02.2022.
//

import UIKit

class RosterTableViewController: UITableViewController, RosterTableViewControllerProtocol {
    
    var presenter: RosterPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ColorScheme.shared.theme.viewControllerBackground
        tableView.register(RosterTableViewCell.self, forCellReuseIdentifier: RosterTableViewCell.identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
        navigationItem.title = presenter?.model.killTeam?.userCustomName ?? presenter?.model.killTeam?.factionName
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return presenter?.model.killTeam?.choosenFireTeam.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = TableHeaderView()
        view.label.text = presenter?.model.killTeam?.choosenFireTeam[section].name
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Constant.Size.headerHeight
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.model.killTeam?.choosenFireTeam[section].currentDataslates.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RosterTableViewCell.identifier, for: indexPath) as! RosterTableViewCell
        guard let unit = presenter?.model.killTeam?.choosenFireTeam[indexPath.section].currentDataslates[indexPath.row]  else { return UITableViewCell() }
        cell.updateCell()
        cell.setupText(unit: unit)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.goToMoreInfoUnit(indexPath: indexPath)
        
    }
}

