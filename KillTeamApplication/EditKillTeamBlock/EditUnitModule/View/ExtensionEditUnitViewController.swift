//
//  ExtensionEditUnitViewController.swift
//  KillTeamApplication
//
//  Created by Apple on 10.04.2022.
//

import Foundation
import UIKit

extension EditUnitViewController {
    
    func registerCell() {
        tableView.register(EditUnitWargearCell.self, forCellReuseIdentifier: EditUnitWargearCell.identifier)
        tableView.register(EditUnitEquipmentCell.self, forCellReuseIdentifier: EditUnitEquipmentCell.identifier)
            createBarlabel()
    }
    
    func createBarlabel() {
        guard let navigationBar = navigationController?.navigationBar,
              let countOfEquipmentPoint = presenter?.model.killTeam?.countEquipmentPoint  else { return }
        navigationBar.addSubview(countOfEquipmentPointLabel)
        countOfEquipmentPointLabel.text = "Count of Equipment Point = \(countOfEquipmentPoint)"
        NSLayoutConstraint.activate([
            countOfEquipmentPointLabel.trailingAnchor.constraint(equalTo: navigationBar.trailingAnchor, constant: -15),
            countOfEquipmentPointLabel.centerYAnchor.constraint(equalTo: navigationBar.centerYAnchor)
        ])
    }
    
    func setupWeaponCell(tableView: UITableView, indexPath: IndexPath, wargear: [Weapon]) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EditUnitWargearCell.identifier, for: indexPath) as! EditUnitWargearCell
        presenter?.store.multicastDelegate.addDelegate(cell)
        cell.wargear = wargear[indexPath.row]
        cell.unit = presenter?.model.currentUnit
        cell.delegate = presenter as? EditUnitCellDelegate
        cell.setupText(weapon: wargear[indexPath.row])
        return cell
    }
    
    func setupEquipmentCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EditUnitEquipmentCell.identifier, for: indexPath) as! EditUnitEquipmentCell
        guard let equipment = presenter?.model.killTeam?.equipment[indexPath.row] else { return UITableViewCell() }
        presenter?.store.multicastDelegate.addDelegate(cell)
        cell.equipment = equipment
        cell.unit = presenter?.model.currentUnit
        cell.delegate = presenter as? EditUnitEquipmentCellDelegate
        cell.setupText(equipment: equipment)
        return cell
    }
    
    func setupWargearView<T: WargearView>(view: T, wargear: T.Wargear, delegate: T.Delegate) {
        view.setupText(wargear: wargear, delegate: delegate as? WeaponRuleButtonProtocol)
        view.setupButton()
        view.setDelegate(delegate: delegate)
        guard let view = view as? UIView else { return }
        view.layer.applyCornerRadius()
        view.layer.masksToBounds = true
    }
    
    func addWeaponAction(wargear: [Weapon], indexPtah: IndexPath) -> UISwipeActionsConfiguration {
        let action = UIContextualAction(style: .normal, title: "More info") { _, _, complition in
            let view = WeaponView()
            self.setupWargearView(view: view, wargear: wargear[indexPtah.row], delegate: self)
            self.showAlert(alertView: view)
        complition(true)
        }
        action.backgroundColor = ColorScheme.shared.theme.swipeInfoAction
        action.title = "Info"
        action.image = UIImage(systemName: "info.circle.fill")
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    func addEquipmentAction(indexPath: IndexPath) -> UISwipeActionsConfiguration {
        let action = UIContextualAction(style: .normal, title: "More info") { _, _, complition in
            guard let equipment = self.presenter?.model.killTeam?.equipment[indexPath.row] else { return }
            let view = EquipmentView()
            self.setupWargearView(view: view, wargear: equipment, delegate: self)
            self.showAlert(alertView: view)
            complition(true)
        }
        action.backgroundColor = ColorScheme.shared.theme.swipeInfoAction
        action.title = "Info"
        action.image = UIImage(systemName: "info.circle.fill")
        return UISwipeActionsConfiguration(actions: [action])
    }
}
