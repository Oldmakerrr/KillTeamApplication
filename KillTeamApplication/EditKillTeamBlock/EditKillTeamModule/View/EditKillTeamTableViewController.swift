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
        view.backgroundColor = UIColor.red
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

        presenter?.additionalSettings(view: self)

        presenter?.goToAddFireTeam()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: EditKillTeamCell.identifire, for: indexPath) as! EditKillTeamCell
        let unit = presenter?.model.killTeam?.choosenFireTeam[indexPath.section].currentDataslates[indexPath.row]
            cell.unitName.text = unit?.customName ?? unit?.name

        
                cell.closeWaepon.text = "Close weapon - \(unit!.selectedCloseWeapon.name)"
        if let rangeWeapon = unit?.selectedRangeWeapon {
            cell.rangeWaepon.text = "Range weapon - \(rangeWeapon.name)"
            
        }
        func printEquipment() -> String {
            var equipmentArray = ""
            var index = 1
            for equipment in unit!.equipment {
                equipmentArray += equipment.name
                if index == unit?.equipment.count {
                    equipmentArray += "."
                } else {
                    equipmentArray += ", "
                }
                index += 1
            }
            return equipmentArray
        }
        
        if !unit!.equipment.isEmpty {
            cell.equipment.text = "Equipment: \(printEquipment())"

        } else {
            cell.equipment.text = ""
        }
        return cell
    }
    
    func createBarButton() {
        goToAddFireTeamButton.title = "Edit"
        navigationItem.rightBarButtonItem = goToAddFireTeamButton
        goToAddFireTeamButton.target = self
        goToAddFireTeamButton.action = #selector(tapBarButtonAdd)
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var sizeCell: CGFloat = 85
        if let unit = presenter?.model.killTeam?.choosenFireTeam[indexPath.section].currentDataslates[indexPath.row] {
            if unit.equipment.isEmpty {
                sizeCell = 85
            } else {
                sizeCell = 105
            }
        }
        return sizeCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.goToEditUnitVC(indexPath: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let changeUnit = presenter?.changeUnitAction(indexPath: indexPath, view: self)
        let addUnit = presenter?.addUnitAction(indexPath: indexPath, view: self)
        let renameUnit = presenter?.renameUnitAction(indexPath: indexPath, view: self)
        return UISwipeActionsConfiguration(actions: [changeUnit!, addUnit!, renameUnit!])
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let removeUnit = presenter?.removeUnitAction(indexPath: indexPath, view: self)
        return UISwipeActionsConfiguration(actions: [removeUnit!])
    }

}



