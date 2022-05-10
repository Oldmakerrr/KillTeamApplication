//
//  EditKillTeamTableViewController.swift
//  KillTeamApplication
//
//  Created by Apple on 19.02.2022.
//

import UIKit

class EditKillTeamTableViewController: UITableViewController, EditKillTeamProtocol {
    
    var presenter: EditKillTeamPresenterProtocol?
    
    let addUnitOrFireTeamButton = AddButton()
    let customTitleView = LabelWithImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ColorScheme.shared.theme.viewControllerBackground
        navigationController?.navigationBar.isHidden = false
        tableView.register(EditKillTeamCell.self, forCellReuseIdentifier: EditKillTeamCell.identifier)
        setupTitleView(name: presenter?.model.killTeam?.userCustomName ?? presenter?.model.killTeam?.killTeamName)
        addGestureToTitleView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
        setupAddButton()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        addUnitOrFireTeamButton.removeFromSuperview()
    }
    
// MARK: - TableViewDataSource

    override func numberOfSections(in tableView: UITableView) -> Int {
        return presenter?.model.killTeam?.choosenFireTeam.count ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.model.killTeam?.choosenFireTeam[section].currentDataslates.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EditKillTeamCell.identifier, for: indexPath) as! EditKillTeamCell
        guard let unit = presenter?.model.killTeam?.choosenFireTeam[indexPath.section].currentDataslates[indexPath.row] else { return UITableViewCell() }
        cell.updateCell()
        cell.setupText(unit: unit)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = TableHeaderView()
        view.label.text = presenter?.model.killTeam?.choosenFireTeam[section].name
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Constant.Size.headerHeight
    }
    
//MARK: - TableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.goToEditUnitVC(indexPath: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let changeUnit = changeUnitAction(indexPath: indexPath)
        let renameUnit = renameUnitAction(indexPath: indexPath)
        return UISwipeActionsConfiguration(actions: [changeUnit, renameUnit])
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let removeUnit = removeUnitAction(indexPath: indexPath)
        return UISwipeActionsConfiguration(actions: [removeUnit])
    }

}
