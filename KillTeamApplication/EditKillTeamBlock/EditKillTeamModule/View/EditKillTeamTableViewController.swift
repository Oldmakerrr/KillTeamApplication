//
//  EditKillTeamTableViewController.swift
//  KillTeamApplication
//
//  Created by Apple on 19.02.2022.
//

import UIKit

class EditKillTeamTableViewController: UITableViewController, EditKillTeamProtocol {
    
    var presenter: EditKillTeamPresenterProtocol?

    var goToAddFireTeamButton = UIBarButtonItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9529411765, blue: 0.9568627451, alpha: 1)
        navigationController?.navigationBar.isHidden = false
        tableView.register(EditKillTeamCell.self, forCellReuseIdentifier: EditKillTeamCell.identifire)
        createBarButton()
        }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
        createBarButton()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationItem.rightBarButtonItems?.removeAll()
    }
    
    @objc func tapBarButtonAdd() {
        presenter?.additionalSettings()
    }
    
    func createBarButton() {
        goToAddFireTeamButton.title = "Edit"
        navigationItem.rightBarButtonItem = goToAddFireTeamButton
        goToAddFireTeamButton.target = self
        goToAddFireTeamButton.action = #selector(tapBarButtonAdd)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return presenter?.model.killTeam?.choosenFireTeam.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return presenter?.model.killTeam?.choosenFireTeam[section].name
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.model.killTeam?.choosenFireTeam[section].currentDataslates.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = EditKillTeamCell()
        guard let unit = presenter?.model.killTeam?.choosenFireTeam[indexPath.section].currentDataslates[indexPath.row] else {
            return UITableViewCell()
        }
        cell.setupText(unit: unit)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.goToEditUnitVC(indexPath: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
       guard let changeUnit = presenter?.changeUnitAction(indexPath: indexPath),
             let renameUnit = presenter?.renameUnitAction(indexPath: indexPath) else { return nil }
        return UISwipeActionsConfiguration(actions: [changeUnit, renameUnit])
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let removeUnit = presenter?.removeUnitAction(indexPath: indexPath)
        return UISwipeActionsConfiguration(actions: [removeUnit!])
    }

}



